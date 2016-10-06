#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xexchexchangecertificate) do

  let :dsc_xexchexchangecertificate do
    Puppet::Type.type(:dsc_xexchexchangecertificate).new(
      :name     => 'foo',
      :dsc_thumbprint => 'foo',
    )
  end

  it 'should allow all properties to be specified' do
    expect { Puppet::Type.type(:dsc_xexchexchangecertificate).new(
      :name     => 'foo',
      :dsc_thumbprint => 'foo',
      :dsc_credential => {"user"=>"user", "password"=>"password"},
      :dsc_ensure => 'Present',
      :dsc_allowextraservices => true,
      :dsc_certcreds => {"user"=>"user", "password"=>"password"},
      :dsc_certfilepath => 'foo',
      :dsc_domaincontroller => 'foo',
      :dsc_services => ["foo", "bar", "spec"],
    )}.to_not raise_error
  end

  it "should stringify normally" do
    expect(dsc_xexchexchangecertificate.to_s).to eq("Dsc_xexchexchangecertificate[foo]")
  end

  it 'should default to ensure => present' do
    expect(dsc_xexchexchangecertificate[:ensure]).to eq :present
  end

  it 'should require that dsc_thumbprint is specified' do
    #dsc_xexchexchangecertificate[:dsc_thumbprint]
    expect { Puppet::Type.type(:dsc_xexchexchangecertificate).new(
      :name     => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_thumbprint is a required attribute/)
  end

  it 'should not accept array for dsc_thumbprint' do
    expect{dsc_xexchexchangecertificate[:dsc_thumbprint] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_thumbprint' do
    expect{dsc_xexchexchangecertificate[:dsc_thumbprint] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_thumbprint' do
    expect{dsc_xexchexchangecertificate[:dsc_thumbprint] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_thumbprint' do
    expect{dsc_xexchexchangecertificate[:dsc_thumbprint] = 16}.to raise_error(Puppet::ResourceError)
  end

  it "should not accept empty password for dsc_credential" do
    expect{dsc_xexchexchangecertificate[:dsc_credential] = {"user"=>"user", "password"=>""}}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_credential' do
    expect{dsc_xexchexchangecertificate[:dsc_credential] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_credential' do
    expect{dsc_xexchexchangecertificate[:dsc_credential] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_credential' do
    expect{dsc_xexchexchangecertificate[:dsc_credential] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_credential' do
    expect{dsc_xexchexchangecertificate[:dsc_credential] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_ensure predefined value Present' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'Present'
    expect(dsc_xexchexchangecertificate[:dsc_ensure]).to eq('Present')
  end

  it 'should accept dsc_ensure predefined value present' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'present'
    expect(dsc_xexchexchangecertificate[:dsc_ensure]).to eq('present')
  end

  it 'should accept dsc_ensure predefined value present and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'present'
    expect(dsc_xexchexchangecertificate[:ensure]).to eq(dsc_xexchexchangecertificate[:dsc_ensure].downcase.to_sym)
  end

  it 'should accept dsc_ensure predefined value Absent' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'Absent'
    expect(dsc_xexchexchangecertificate[:dsc_ensure]).to eq('Absent')
  end

  it 'should accept dsc_ensure predefined value absent' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'absent'
    expect(dsc_xexchexchangecertificate[:dsc_ensure]).to eq('absent')
  end

  it 'should accept dsc_ensure predefined value absent and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xexchexchangecertificate[:dsc_ensure] = 'absent'
    expect(dsc_xexchexchangecertificate[:ensure]).to eq(dsc_xexchexchangecertificate[:dsc_ensure].downcase.to_sym)
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xexchexchangecertificate[:dsc_ensure] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ensure' do
    expect{dsc_xexchexchangecertificate[:dsc_ensure] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ensure' do
    expect{dsc_xexchexchangecertificate[:dsc_ensure] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ensure' do
    expect{dsc_xexchexchangecertificate[:dsc_ensure] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ensure' do
    expect{dsc_xexchexchangecertificate[:dsc_ensure] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_allowextraservices' do
    expect{dsc_xexchexchangecertificate[:dsc_allowextraservices] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it "should accept boolean-like value 'true' and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = 'true'
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean('true'))
  end

  it "should accept boolean-like value 'false' and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = 'false'
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean('false'))
  end

  it "should accept boolean-like value 'True' and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = 'True'
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean('True'))
  end

  it "should accept boolean-like value 'False' and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = 'False'
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean('False'))
  end

  it "should accept boolean-like value :true and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = :true
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean(:true))
  end

  it "should accept boolean-like value :false and munge this value to boolean for dsc_allowextraservices" do
    dsc_xexchexchangecertificate[:dsc_allowextraservices] = :false
    expect(dsc_xexchexchangecertificate[:dsc_allowextraservices]).to eq(PuppetX::Dsc::TypeHelpers.munge_boolean(:false))
  end

  it 'should not accept int for dsc_allowextraservices' do
    expect{dsc_xexchexchangecertificate[:dsc_allowextraservices] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_allowextraservices' do
    expect{dsc_xexchexchangecertificate[:dsc_allowextraservices] = 16}.to raise_error(Puppet::ResourceError)
  end

  it "should not accept empty password for dsc_certcreds" do
    expect{dsc_xexchexchangecertificate[:dsc_certcreds] = {"user"=>"user", "password"=>""}}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_certcreds' do
    expect{dsc_xexchexchangecertificate[:dsc_certcreds] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_certcreds' do
    expect{dsc_xexchexchangecertificate[:dsc_certcreds] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_certcreds' do
    expect{dsc_xexchexchangecertificate[:dsc_certcreds] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_certcreds' do
    expect{dsc_xexchexchangecertificate[:dsc_certcreds] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_certfilepath' do
    expect{dsc_xexchexchangecertificate[:dsc_certfilepath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_certfilepath' do
    expect{dsc_xexchexchangecertificate[:dsc_certfilepath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_certfilepath' do
    expect{dsc_xexchexchangecertificate[:dsc_certfilepath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_certfilepath' do
    expect{dsc_xexchexchangecertificate[:dsc_certfilepath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_domaincontroller' do
    expect{dsc_xexchexchangecertificate[:dsc_domaincontroller] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_domaincontroller' do
    expect{dsc_xexchexchangecertificate[:dsc_domaincontroller] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_domaincontroller' do
    expect{dsc_xexchexchangecertificate[:dsc_domaincontroller] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_domaincontroller' do
    expect{dsc_xexchexchangecertificate[:dsc_domaincontroller] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept array for dsc_services' do
    dsc_xexchexchangecertificate[:dsc_services] = ["foo", "bar", "spec"]
    expect(dsc_xexchexchangecertificate[:dsc_services]).to eq(["foo", "bar", "spec"])
  end

  it 'should not accept boolean for dsc_services' do
    expect{dsc_xexchexchangecertificate[:dsc_services] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_services' do
    expect{dsc_xexchexchangecertificate[:dsc_services] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_services' do
    expect{dsc_xexchexchangecertificate[:dsc_services] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xexchexchangecertificate)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xexchexchangecertificate)
    end

    describe "when dscmeta_module_name existing/is defined " do

      it "should compute powershell dsc test script with Invoke-DscResource" do
        expect(@provider.ps_script_content('test')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Test" do
        expect(@provider.ps_script_content('test')).to match(/Method\s+=\s*'test'/)
      end

      it "should compute powershell dsc set script with Invoke-DscResource" do
        expect(@provider.ps_script_content('set')).to match(/Invoke-DscResource/)
      end

      it "should compute powershell dsc test script with method Set" do
        expect(@provider.ps_script_content('set')).to match(/Method\s+=\s*'set'/)
      end

    end

    describe "when dsc_ensure is 'present'" do

      before(:each) do
        dsc_xexchexchangecertificate.original_parameters[:dsc_ensure] = 'present'
        dsc_xexchexchangecertificate[:dsc_ensure] = 'present'
        @provider = described_class.provider(:powershell).new(dsc_xexchexchangecertificate)
      end

      it "should update :ensure to :present" do
        expect(dsc_xexchexchangecertificate[:ensure]).to eq(:present)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('set')).to match(/ensure = 'present'/)
      end

    end

    describe "when dsc_ensure is 'absent'" do

      before(:each) do
        dsc_xexchexchangecertificate.original_parameters[:dsc_ensure] = 'absent'
        dsc_xexchexchangecertificate[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:powershell).new(dsc_xexchexchangecertificate)
      end

      it "should update :ensure to :absent" do
        expect(dsc_xexchexchangecertificate[:ensure]).to eq(:absent)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'absent'" do
        expect(@provider.ps_script_content('set')).to match(/ensure = 'absent'/)
      end

    end

    describe "when dsc_resource has credentials" do

      it "should convert credential hash to a pscredential object" do
        expect(@provider.ps_script_content('test')).to match(/| new-pscredential'/)
      end

    end


  end
end
