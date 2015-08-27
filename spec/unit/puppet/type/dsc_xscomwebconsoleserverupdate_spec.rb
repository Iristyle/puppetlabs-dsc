#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xscomwebconsoleserverupdate) do

  let :dsc_xscomwebconsoleserverupdate do
    Puppet::Type.type(:dsc_xscomwebconsoleserverupdate).new(
      :name     => 'foo',
      :dsc_ensure => 'Present',
    )
  end

  it "should stringify normally" do
    expect(dsc_xscomwebconsoleserverupdate.to_s).to eq("Dsc_xscomwebconsoleserverupdate[foo]")
  end

  it 'should default to ensure => present' do
    expect(dsc_xscomwebconsoleserverupdate[:ensure]).to eq :present
  end

  it 'should require that dsc_ensure is specified' do
    #dsc_xscomwebconsoleserverupdate[:dsc_ensure]
    expect { Puppet::Type.type(:dsc_xscomwebconsoleserverupdate).new(
      :name     => 'foo',
      :dsc_sourcepath => 'foo',
      :dsc_sourcefolder => 'foo',
      :dsc_setupcredential => {"user"=>"user", "password"=>"password"},
      :dsc_update => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_ensure is a required attribute/)
  end

  it 'should accept dsc_ensure predefined value Present' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'Present'
    expect(dsc_xscomwebconsoleserverupdate[:dsc_ensure]).to eq('Present')
  end

  it 'should accept dsc_ensure predefined value present' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'present'
    expect(dsc_xscomwebconsoleserverupdate[:dsc_ensure]).to eq('present')
  end

  it 'should accept dsc_ensure predefined value present and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'present'
    expect(dsc_xscomwebconsoleserverupdate[:ensure]).to eq(dsc_xscomwebconsoleserverupdate[:dsc_ensure].downcase.to_sym)
  end

  it 'should accept dsc_ensure predefined value Absent' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'Absent'
    expect(dsc_xscomwebconsoleserverupdate[:dsc_ensure]).to eq('Absent')
  end

  it 'should accept dsc_ensure predefined value absent' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'absent'
    expect(dsc_xscomwebconsoleserverupdate[:dsc_ensure]).to eq('absent')
  end

  it 'should accept dsc_ensure predefined value absent and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'absent'
    expect(dsc_xscomwebconsoleserverupdate[:ensure]).to eq(dsc_xscomwebconsoleserverupdate[:dsc_ensure].downcase.to_sym)
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ensure' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_ensure] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ensure' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_ensure] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ensure' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_ensure] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ensure' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_sourcepath' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcepath] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_sourcepath' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcepath] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_sourcepath' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcepath] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_sourcepath' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcepath] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_sourcefolder' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcefolder] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_sourcefolder' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcefolder] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_sourcefolder' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcefolder] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_sourcefolder' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_sourcefolder] = 16}.to raise_error(Puppet::ResourceError)
  end

  # TODO: this test is not right yet
  it 'should accept array for dsc_setupcredential' do
    dsc_xscomwebconsoleserverupdate[:dsc_setupcredential] = {"user"=>"user", "password"=>"password"}
    expect(dsc_xscomwebconsoleserverupdate[:dsc_setupcredential]).to eq({"user"=>"user", "password"=>"password"})
  end

  it 'should not accept boolean for dsc_setupcredential' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_setupcredential] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_setupcredential' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_setupcredential] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_setupcredential' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_setupcredential] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_update' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_update] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_update' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_update] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_update' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_update] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_update' do
    expect{dsc_xscomwebconsoleserverupdate[:dsc_update] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xscomwebconsoleserverupdate)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xscomwebconsoleserverupdate)
    end

    describe "when dscmeta_import_resource is true (default) and dscmeta_module_name existing/is defined " do

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
        dsc_xscomwebconsoleserverupdate.original_parameters[:dsc_ensure] = 'present'
        dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'present'
        @provider = described_class.provider(:powershell).new(dsc_xscomwebconsoleserverupdate)
      end

      it "should update :ensure to :present" do
        expect(dsc_xscomwebconsoleserverupdate[:ensure]).to eq(:present)
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
        dsc_xscomwebconsoleserverupdate.original_parameters[:dsc_ensure] = 'absent'
        dsc_xscomwebconsoleserverupdate[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:powershell).new(dsc_xscomwebconsoleserverupdate)
      end

      it "should update :ensure to :absent" do
        expect(dsc_xscomwebconsoleserverupdate[:ensure]).to eq(:absent)
      end

      it "should compute powershell dsc test script in which ensure value is 'present'" do
        expect(@provider.ps_script_content('test')).to match(/ensure = 'present'/)
      end

      it "should compute powershell dsc set script in which ensure value is 'absent'" do
        expect(@provider.ps_script_content('set')).to match(/ensure = 'absent'/)
      end

    end

    describe "when dsc_resource has credentials" do

      before(:each) do
        @provider = described_class.provider(:powershell).new(dsc_xscomwebconsoleserverupdate)
      end

      it "should convert credential hash to a pscredential object" do
        expect(@provider.ps_script_content('test')).to match(/| new-pscredential'/)
      end

    end


  end
end
