require 'erb'
require 'dsc_utils'
test_name 'MODULES-2286 - C68561 - Apply DSC File Resource with Valid Unicode "SourcePath" Specified'

confine(:to, :platform => 'windows')

# Init
local_files_root_path = ENV['MANIFESTS'] || 'tests/manifests'
test_manifest_name = 'test_manifest.pp'
test_file_name = 'test.file'
source_file_name = "\u3172\u3142\u3144\u3149\u3151\u3167\u3169\u3159\u3158\u3140\u3145\u3176\u3145"
temp_id = SecureRandom.uuid
temp_dsc_path = "c:\\windows\\temp\\#{temp_id}"
temp_shell_path = "/cygdrive/c/windows/temp/#{temp_id}"

# ERB Manifest
dsc_type = 'file'
dsc_module = 'PSDesiredStateConfiguration'
dsc_props = {
  :dsc_ensure          => 'Present',
  :dsc_destinationpath => "#{temp_dsc_path}\\#{test_file_name}",
  :dsc_sourcepath      => "#{temp_dsc_path}\\#{source_file_name}"
}

dsc_manifest_template_path = File.join(local_files_root_path, 'basic_dsc_resources', 'dsc_single_resource.pp.erb')
dsc_manifest = ERB.new(File.read(dsc_manifest_template_path), 0, '>').result(binding)

# Teardown
teardown do
  step 'Remove Test Artifacts'
  # BKR-652 - This succeeds with a proper channel.close added to net-scp-1.2.1/lib/net/scp.rb
  # on(agents, "cmd.exe /c \"rd /s /q #{temp_dsc_path}\"")
  on(agents, "rm -rf #{temp_shell_path}")
end

# Verify
source_file_contents = 'Valid data!'

# Setup
on(agents, "mkdir -p #{temp_shell_path}")
create_remote_file(agents, "#{temp_dsc_path}\\#{test_manifest_name}", dsc_manifest)
# TODO: BKR-652 this currently barfs due to https://tickets.puppetlabs.com/browse/BKR-652
create_remote_file(agents, "#{temp_dsc_path}\\#{source_file_name}", source_file_contents)

# Tests
agents.each do |agent|
  step 'Apply Manifest'
  on(agent, puppet("apply #{temp_dsc_path}\\\\#{test_manifest_name}"), :acceptable_exit_codes => [0,2]) do |result|
    expect_failure('Expected to fail because of MODULES-2310') do
      assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
    end
  end

  step 'Verify Results'
  on(agent, "cat #{temp_shell_path}/#{test_file_name}", :acceptable_exit_codes => 1) do |result|
    expect_failure('Expected to fail because of MODULES-2310') do
      assert_match(/\A#{source_file_contents}\z/, result.stdout, 'File content is invalid!')
    end
  end
end
