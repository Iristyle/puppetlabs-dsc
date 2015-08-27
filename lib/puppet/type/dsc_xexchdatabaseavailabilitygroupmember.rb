require 'pathname'

Puppet::Type.newtype(:dsc_xexchdatabaseavailabilitygroupmember) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xExchDatabaseAvailabilityGroupMember resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xExchange/DSCResources/MSFT_xExchDatabaseAvailabilityGroupMember/MSFT_xExchDatabaseAvailabilityGroupMember.schema.mof
  }

  validate do
      fail('dsc_mailboxserver is a required attribute') if self[:dsc_mailboxserver].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xExchDatabaseAvailabilityGroupMember"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xExchDatabaseAvailabilityGroupMember"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xExchange"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.2.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto do :present end
  end

  # Name:         MailboxServer
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_mailboxserver) do
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Credential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_credential) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DAGName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_dagname) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DomainController
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_domaincontroller) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SkipDagValidation
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_skipdagvalidation) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
