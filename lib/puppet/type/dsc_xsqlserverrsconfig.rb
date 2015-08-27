require 'pathname'

Puppet::Type.newtype(:dsc_xsqlserverrsconfig) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xSQLServerRSConfig resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xSQLServer/DSCResources/MSFT_xSQLServerRSConfig/MSFT_xSQLServerRSConfig.schema.mof
  }

  validate do
      fail('dsc_instancename is a required attribute') if self[:dsc_instancename].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xSQLServerRSConfig"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xSQLServerRSConfig"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xSQLServer"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.3.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         InstanceName
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_instancename) do
    def mof_type; 'string' end
    desc "Name of the SQL Server Reporting Services instance to be configured."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RSSQLServer
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_rssqlserver) do
    def mof_type; 'string' end
    desc "Name of the SQL Server to host the Reporting Service database."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RSSQLInstanceName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_rssqlinstancename) do
    def mof_type; 'string' end
    desc "Name of the SQL Server instance to host the Reporting Service database."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SQLAdminCredential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sqladmincredential) do
    def mof_type; 'MSFT_Credential' end
    desc "Credential to be used to perform the configuration."
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      required = ['user', 'password']
      missing = required - value.keys.map(&:to_s)
      unless missing.empty?
        fail "for SQLAdminCredential you are missing the following keys: #{missing.join(',')}"
      end
      required.each do |key|
        if value[key]
          fail "#{key} for SQLAdminCredential should be a String" unless value[key].is_a? String
        end
      end
    end
  end

  # Name:         IsInitialized
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_isinitialized) do
    def mof_type; 'boolean' end
    desc "Is the Reporting Services instance initialized."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
