require 'open3'
require 'thread'

module PuppetX::Dsc
  class PowerShellManager
    @@instances = {}

    def self.instance(cmd)
      @@instances[:cmd] ||= PowerShellManager.new(cmd)
    end

    def initialize(cmd)
      stdin_r, @stdin = IO.pipe
      @stdout, stdout_w = IO.pipe

      stdin_r.sync = true
      @stdin.sync = true
      @stdout.sync = true
      stdout_w.sync = true
      @pid = Process.spawn(cmd, :in => stdin_r, :out => stdout_w)
      Process.detach(@pid)

      Puppet.debug "#{Time.now} #{cmd} is running as pid: #{@pid}"

      at_exit { exit }
    end

    def self.is_readable?(stream, timeout = 0.5)
      read_ready = IO.select([stream], [], [], timeout)
      read_ready && stream == read_ready[0][0]
    end

    def self.is_writable?(stream, timeout = 2)
      write_ready = IO.select([], [stream], [], timeout)
      write_ready && stream == write_ready[1][0]
    end

    def execute(powershell_code)
      # always need a trailing newline to ensure PowerShell parses code
      out = exec_read_result(<<-CODE
      $Error.Clear()
      $LASTEXITCODE = 0
      #{powershell_code}
      [Console]::Out.Flush()
      [Console]::Error.Flush()

      CODE
      )

      { :stdout => out }
    end

    def exit
      Puppet.debug "PowerShellManager exiting..."
      @stdin.puts "\nexit\n"
      @stdin.close
      @stdout.close
      # TODO: kill if not exited in X seconds?
      @return_code = Process::waitpid(@pid, 2)
    end

    private

    def write_stdin(input)
      raise "Unwriteable stream" if !self.class.is_writable?(@stdin)

      @stdin.puts(input)
      @stdin.flush()
    rescue => e
      Puppet.warning "Error writing STDIN / reading STDOUT: #{e}"
    end

    def read_stdout
      output = []
      # TODO: seems to need an initial timeout on first run
      # otherwise we drop output on 1st or 2nd resource and return something like:
      #  Could not evaluate: A JSON text must at least contain two octets!
      # unfortunately this drives up overall execution time considerably
      while self.class.is_readable?(@stdout, 2) do
        # this is necessary to ensure all output captured
        @stdout.flush()

        l = @stdout.gets
        Puppet.debug "#{Time.now} STDOUT> #{l}"
        output << l

        # We need a way to get to process status.
        # I'm not going to trust $? is going to
        # give us the right thing. Especially on
        # Windows.

        #if !proc_thread.alive?
        #  Puppet.debug "#{Time.now} #{cmd} has exited for unknown reasons."
        #  raise "Process #{cmd} has exited, possibly due to malformed command."
        #end
      end

      return output.join('')
    rescue => e
      Puppet.warning "Error reading STDOUT: #{e}"
      ''
    end

    def exec_read_result(powershell_code)
      write_stdin(powershell_code)
      read_stdout
    end
  end
end
