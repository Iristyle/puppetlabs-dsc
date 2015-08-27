require 'pathname'

Puppet::Type.newtype(:dsc_xcertreq) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xCertReq resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xCertificate/DSCResources/MSFT_xCertReq/MSFT_xCertReq.schema.mof
  }

  validate do
      fail('dsc_subject is a required attribute') if self[:dsc_subject].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xCertReq"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xCertReq"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xCertificate"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.0.1.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         Subject
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_subject) do
    def mof_type; 'string' end
    desc "Provide the text string to use as the subject of the certificate"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CAServerFQDN
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_caserverfqdn) do
    def mof_type; 'string' end
    desc "The FQDN of the Active Directory Certificate Authority on the local area network"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CARootName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_carootname) do
    def mof_type; 'string' end
    desc "The name of the certificate authority, by default this will be in format domain-servername-ca"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Credential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_credential) do
    def mof_type; 'MSFT_Credential' end
    desc "The credentials that will be used to access the template in the Certificate Authority"
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      required = ['user', 'password']
      missing = required - value.keys.map(&:to_s)
      unless missing.empty?
        fail "for Credential you are missing the following keys: #{missing.join(',')}"
      end
      required.each do |key|
        if value[key]
          fail "#{key} for Credential should be a String" unless value[key].is_a? String
        end
      end
    end
  end

  # Name:         AutoRenew
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_autorenew) do
    def mof_type; 'boolean' end
    desc "Determines if the resource will also renew a certificate within 7 days of expiration"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
