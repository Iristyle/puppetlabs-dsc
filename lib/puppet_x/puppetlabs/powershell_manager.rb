require 'open3'
require 'thread'

module PuppetX::Dsc
  class PowerShellManager
    attr_accessor :return_code

    @@instances = {}

    def self.instance(cmd)
      @@instances[:cmd] ||= PowerShellManager.new(cmd)
    end

    def initialize(cmd)
      process_init_lock = Mutex.new
      process_started = ConditionVariable.new

      @stream_lock = Mutex.new

      process_init_lock.synchronize do
        @runner_thread = Thread.new do
          begin
            Open3::popen2(cmd) do |stdin, stdout, proc_thread|
              Puppet.debug "#{Time.now} #{cmd} is running as pid: #{proc_thread.pid}"

              @stdin = stdin
              @stdout = stdout
              stdin.sync = true
              stdout.sync = true

              process_started.signal()

              proc_thread.join
              @return_code = proc_thread.value
            end
          # process not found or otherwise failed to start
          rescue Exception => e
            process_started.signal()
            @return_code = -1
          end
        end
      end

      # block initializer until process started with popen
      process_init_lock.synchronize do
        process_started.wait(process_init_lock)
      end

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
      @runner_thread.join
    end

    private

    def write_stdin(input)
      begin
        # clear previously captured output
        @stream_lock.synchronize do
          raise "Unwriteable stream" if !self.class.is_writable?(@stdin)

          @stdin.puts(input)
          @stdin.flush()
          # TODO: need to make sure Ruby wakes up thread responsible for powershell.exe
          # only thing that works is sleep for a high amount of time - i.e. sleep(1)
          sleep(1)
        end
      rescue => e
        Puppet.debug "Error writing STDIN / reading STDOUT: #{e}"
      end
    end

    def read_stdout
      result = ''

      begin
        @stream_lock.synchronize do
          @stdout.flush()

          Thread.pass

          # while !@stdout.eof? do
          # this is necessary to ensure all output captured
          output = []
          while self.class.is_readable?(@stdout) do
            l = @stdout.gets
            Puppet.debug "#{Time.now} STDOUT> #{l}"
            output << l
          end

          result = output.join('')
        end
      rescue => e
        Puppet.debug "Error reading STDOUT: #{e}"
      end

      result
    end

    def exec_read_result(powershell_code)
      write_stdin(powershell_code)
      read_stdout
    end
  end
end
