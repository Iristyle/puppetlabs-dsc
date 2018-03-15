require 'pathname'

Puppet::Type.newtype(:dsc_xdnsserverprimaryzone) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'
  require Pathname.new(__FILE__).dirname + '../../puppet_x/puppetlabs/dsc_type_helpers'


  @doc = %q{
    The DSC xDnsServerPrimaryZone resource type.
    Automatically generated from
    'xDnsServer/DSCResources/MSFT_xDnsServerPrimaryZone/MSFT_xDnsServerPrimaryZone.schema.mof'

    To learn more about PowerShell Desired State Configuration, please
    visit https://technet.microsoft.com/en-us/library/dn249912.aspx.

    For more information about built-in DSC Resources, please visit
    https://technet.microsoft.com/en-us/library/dn249921.aspx.

    For more information about xDsc Resources, please visit
    https://github.com/PowerShell/DscResources.
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  def dscmeta_resource_friendly_name; 'xDnsServerPrimaryZone' end
  def dscmeta_resource_name; 'MSFT_xDnsServerPrimaryZone' end
  def dscmeta_module_name; 'xDnsServer' end
  def dscmeta_module_version; '1.9.0.0' end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         PsDscRunAsCredential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_psdscrunascredential) do
    def mof_type; 'MSFT_Credential' end
    def mof_is_embedded?; true end
    desc "PsDscRunAsCredential"
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      PuppetX::Dsc::TypeHelpers.validate_MSFT_Credential("Credential", value)
    end
  end

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Name - DNS Server primary zone name"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ZoneFile
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_zonefile) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "ZoneFile - DNS Server primary zone file"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DynamicUpdate
  # Type:         string
  # IsMandatory:  False
  # Values:       ["None", "NonsecureAndSecure"]
  newparam(:dsc_dynamicupdate) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "DynamicUpdate - Dynamic zone update option Valid values are None, NonsecureAndSecure."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['None', 'none', 'NonsecureAndSecure', 'nonsecureandsecure'].include?(value)
        fail("Invalid value '#{value}'. Valid values are None, NonsecureAndSecure")
      end
    end
  end

  # Name:         Ensure
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Present", "Absent"]
  newparam(:dsc_ensure) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Ensure - Whether the DNS zone should be available or removed Valid values are Present, Absent."
    validate do |value|
      resource[:ensure] = value.downcase
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Present', 'present', 'Absent', 'absent'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Present, Absent")
      end
    end
  end


  def builddepends
    pending_relations = super()
    PuppetX::Dsc::TypeHelpers.ensure_reboot_relationship(self, pending_relations)
  end
end

Puppet::Type.type(:dsc_xdnsserverprimaryzone).provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
  confine :feature => :dsc
  defaultfor :operatingsystem => :windows

  mk_resource_methods
end
