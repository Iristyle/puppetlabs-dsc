require 'securerandom'
require 'open3'
require 'thread'
require 'ffi'

module PuppetX::Dsc
  class PowerShellManager
    extend Puppet::Util::Windows::String
    extend FFI::Library

    @@instances = {}

    def self.instance(cmd)
      @@instances[:cmd] ||= PowerShellManager.new(cmd)
    end

    def initialize(cmd)
      # TODO: CreateMutex with LPSECURITY_ATTRIBUTES and allow
      # child processes access to it - use NULL attributes for now
      @mutex_name = "Global\\#{SecureRandom.uuid}"
      @mutex_handle = create_mutex(@mutex_name)

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
      require 'pry'; binding.pry
      out = exec_read_result(<<-CODE
      [threading.thread]::CurrentThread.ManagedThreadId
      $mutex = [Threading.Mutex]::OpenExisting("#{@mutex_name}")
      [threading.thread]::CurrentThread.ManagedThreadId
      # $mutex = New-Object Threading.Mutex($true, "#{@mutex_name}")
      [threading.thread]::CurrentThread.ManagedThreadId
      $Error.Clear()
      [threading.thread]::CurrentThread.ManagedThreadId
      $LASTEXITCODE = 0
      [threading.thread]::CurrentThread.ManagedThreadId
      #{powershell_code}
      [Console]::Out.Flush()
      [threading.thread]::CurrentThread.ManagedThreadId
      [Console]::Error.Flush()


      # $mutex | Format-List
      [threading.thread]::CurrentThread.ManagedThreadId
      $mutex.ReleaseMutex()
      [threading.thread]::CurrentThread.ManagedThreadId
      CODE
      )


      { :stdout => out }
    end

    def exit
      Puppet.debug "PowerShellManager exiting..."
      @stdin.puts "\nexit\n"
      @stdin.close
      @stdout.close

      FFI::WIN32.CloseHandle(@mutex_handle) if @mutex_handle

      # TODO: kill if not exited in X seconds?
      @return_code = Process::waitpid(@pid, 2)
    end

    private

    # The specified object is a mutex object that was not released by the thread that owned the mutex object before the owning thread terminated. Ownership of the mutex object is granted to the calling thread and the mutex state is set to nonsignaled.
    # If the mutex was protecting persistent state information, you should check it for consistency.
    WAIT_ABANDONED = 0x00000080
    # The state of the specified object is signaled.
    WAIT_OBJECT_0 = 0x00000000
    # The time-out interval elapsed, and the object's state is nonsignaled.
    WAIT_TIMEOUT = 0x00000102
    # Complete failure
    WAIT_FAILED = 0xFFFFFFFF

    def create_mutex(name, own = false)
      handle = FFI::Pointer::NULL_HANDLE

      FFI::Pointer.from_string_to_wide_string(name) do |name_ptr|
        handle = CreateMutexW(FFI::Pointer::NULL,
          own ? 1 : FFI::WIN32_FALSE,
          name_ptr)

        if handle == FFI::Pointer::NULL_HANDLE
          msg = "Failed to create new mutex #{name}"
          raise Puppet::Util::Windows::Error.new(msg)
        end
      end

      handle
    end

    def release_mutex
      result = ReleaseMutex(@mutex_handle)
      if (result == FFI::WIN32_FALSE)
        Puppet.warning("Failed to release mutex #{@mutex_name}")
      end
    end

    def wait_on_mutex(milliseconds = 20 * 1000)
      # wait 200ms at a time until signaled

      wait_ms = 200
      while true
        require 'pry'; binding.pry
        wait_result = Puppet::Util::Windows::Process::WaitForSingleObject(@mutex_handle, wait_ms)
        case wait_result
        when WAIT_OBJECT_0
          return
        when WAIT_TIMEOUT
          total += wait_ms
          require 'pry'; binding.pry if (total > milliseconds)
          raise 'Wuh-oh wait exceeded' if (total > milliseconds)
        when WAIT_ABANDONED
          require 'pry'; binding.pry
          raise 'Wuh-oh buddy...'
        when WAIT_FAILED
          require 'pry'; binding.pry
          raise 'Failure to wait on mutex'
        end
      end
    end

    def write_stdin(input)
      raise "Unwriteable stream" if !self.class.is_writable?(@stdin)

      @stdin.puts(input)
      @stdin.flush()
    rescue => e
      Puppet.warning "Error writing STDIN / reading STDOUT: #{e}"
    end

    def read_stdout
      output = []
      @stdout.flush()
      wait_on_mutex()

      # TODO: seems to need an initial timeout on first run
      # otherwise we drop output on 1st or 2nd resource and return something like:
      #  Could not evaluate: A JSON text must at least contain two octets!
      # unfortunately this drives up overall execution time considerably
      while self.class.is_readable?(@stdout, 0.1) do
        # this is necessary to ensure all output captured
        @stdout.flush()

        l = @stdout.gets
        Puppet.debug "#{Time.now} STDOUT> #{l}"
        output << l
      end

      return output.join('')
    rescue => e
      Puppet.warning "Error reading STDOUT: #{e}"
      ''
    end

    def exec_read_result(powershell_code)
      write_stdin(powershell_code)
      read_stdout
      release_mutex
    end

    ffi_convention :stdcall

    # https://msdn.microsoft.com/en-us/library/windows/desktop/aa379561(v=vs.85).aspx
    # SECURITY_DESCRIPTOR

    # https://msdn.microsoft.com/en-us/library/windows/desktop/aa379560(v=vs.85).aspx
    # typedef struct _SECURITY_ATTRIBUTES {
    #   DWORD  nLength;
    #   LPVOID lpSecurityDescriptor;
    #   BOOL   bInheritHandle;
    # } SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;
    # class SECURITY_ATTRIBUTES < FFI::Struct
    #   layout :nLength, :dword,
    #          :lpSecurityDescriptor, :lpvoid,
    #          :bInheritHandle, :win32_bool
    # end

    # https://msdn.microsoft.com/en-us/library/windows/desktop/ms682411(v=vs.85).aspx
    # HANDLE WINAPI CreateMutex(
    #   _In_opt_ LPSECURITY_ATTRIBUTES lpMutexAttributes,
    #   _In_     BOOL                  bInitialOwner,
    #   _In_opt_ LPCTSTR               lpName
    # );
    ffi_lib :kernel32
    attach_function :CreateMutexW, [:pointer, :win32_bool, :lpcwstr], :handle
    # attach_function :CreateMutexW, [SECURITY_ATTRIBUTES, :win32_bool, :lpcwstr], :handle

    # https://msdn.microsoft.com/en-us/library/windows/desktop/ms682418(v=vs.85).aspx
    # HANDLE WINAPI CreateMutexEx(
    #   _In_opt_ LPSECURITY_ATTRIBUTES lpMutexAttributes,
    #   _In_opt_ LPCTSTR               lpName,
    #   _In_     DWORD                 dwFlags,
    #   _In_     DWORD                 dwDesiredAccess
    # );
    # CREATE_MUTEX_INITIAL_OWNER = 0x00000001
    attach_function :CreateMutexExW, [:pointer, :lpcwstr, :dword, :dword], :handle

    # https://msdn.microsoft.com/en-us/library/windows/desktop/ms685066(v=vs.85).aspx
    # BOOL WINAPI ReleaseMutex(
    #   _In_ HANDLE hMutex
    # );
    ffi_lib :kernel32
    attach_function :ReleaseMutex, [:handle], :win32_bool
  end
end
