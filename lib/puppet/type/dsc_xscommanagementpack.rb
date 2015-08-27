require 'pathname'

Puppet::Type.newtype(:dsc_xscommanagementpack) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xSCOMManagementPack resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xSCOM/DSCResources/MSFT_xSCOMManagementPack/MSFT_xSCOMManagementPack.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xSCOMManagementPack"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xSCOMManagementPack"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xSCOM"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.3.3.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
    def mof_type; 'string' end
    desc "Name of the Management Pack."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Version
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_version) do
    def mof_type; 'string' end
    desc "Specific version of the Management Pack, overrides MinVersion if both set."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         MinVersion
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_minversion) do
    def mof_type; 'string' end
    desc "Minimum version of the Management Pack, overridden by Version if both set."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCOMAdminCredential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scomadmincredential) do
    def mof_type; 'MSFT_Credential' end
    desc "Credential with admin permissions to Operations Manager."
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      required = ['user', 'password']
      missing = required - value.keys.map(&:to_s)
      unless missing.empty?
        fail "for SCOMAdminCredential you are missing the following keys: #{missing.join(',')}"
      end
      required.each do |key|
        if value[key]
          fail "#{key} for SCOMAdminCredential should be a String" unless value[key].is_a? String
        end
      end
    end
  end

  # Name:         SourcePath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sourcepath) do
    def mof_type; 'string' end
    desc "UNC path to the root of the source files for installation, if omitted the Operations Manager installation folder will be used."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SourceFolder
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sourcefolder) do
    def mof_type; 'string' end
    desc "Folder within the source path containing the source files for installation."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SourceFile
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sourcefile) do
    def mof_type; 'string' end
    desc "Name of the file in the source folder for the Management Pack."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
