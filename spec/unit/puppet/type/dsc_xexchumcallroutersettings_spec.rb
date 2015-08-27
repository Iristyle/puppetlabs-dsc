#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xexchumcallroutersettings) do

  let :dsc_xexchumcallroutersettings do
    Puppet::Type.type(:dsc_xexchumcallroutersettings).new(
      :name     => 'foo',
      :dsc_server => 'foo',
    )
  end

  it "should stringify normally" do
    expect(dsc_xexchumcallroutersettings.to_s).to eq("Dsc_xexchumcallroutersettings[foo]")
  end

  it 'should require that dsc_server is specified' do
    #dsc_xexchumcallroutersettings[:dsc_server]
    expect { Puppet::Type.type(:dsc_xexchumcallroutersettings).new(
      :name     => 'foo',
      :dsc_credential => 'foo',
      :dsc_umstartupmode => 'TCP',
      :dsc_domaincontroller => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_server is a required attribute/)
  end

  it 'should not accept array for dsc_server' do
    expect{dsc_xexchumcallroutersettings[:dsc_server] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_server' do
    expect{dsc_xexchumcallroutersettings[:dsc_server] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_server' do
    expect{dsc_xexchumcallroutersettings[:dsc_server] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_server' do
    expect{dsc_xexchumcallroutersettings[:dsc_server] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_credential' do
    expect{dsc_xexchumcallroutersettings[:dsc_credential] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_credential' do
    expect{dsc_xexchumcallroutersettings[:dsc_credential] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_credential' do
    expect{dsc_xexchumcallroutersettings[:dsc_credential] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_credential' do
    expect{dsc_xexchumcallroutersettings[:dsc_credential] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_umstartupmode predefined value TCP' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'TCP'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('TCP')
  end

  it 'should accept dsc_umstartupmode predefined value tcp' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'tcp'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('tcp')
  end

  it 'should accept dsc_umstartupmode predefined value TLS' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'TLS'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('TLS')
  end

  it 'should accept dsc_umstartupmode predefined value tls' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'tls'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('tls')
  end

  it 'should accept dsc_umstartupmode predefined value Dual' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'Dual'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('Dual')
  end

  it 'should accept dsc_umstartupmode predefined value dual' do
    dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'dual'
    expect(dsc_xexchumcallroutersettings[:dsc_umstartupmode]).to eq('dual')
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_umstartupmode' do
    expect{dsc_xexchumcallroutersettings[:dsc_umstartupmode] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_umstartupmode' do
    expect{dsc_xexchumcallroutersettings[:dsc_umstartupmode] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_umstartupmode' do
    expect{dsc_xexchumcallroutersettings[:dsc_umstartupmode] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_umstartupmode' do
    expect{dsc_xexchumcallroutersettings[:dsc_umstartupmode] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_domaincontroller' do
    expect{dsc_xexchumcallroutersettings[:dsc_domaincontroller] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_domaincontroller' do
    expect{dsc_xexchumcallroutersettings[:dsc_domaincontroller] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_domaincontroller' do
    expect{dsc_xexchumcallroutersettings[:dsc_domaincontroller] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_domaincontroller' do
    expect{dsc_xexchumcallroutersettings[:dsc_domaincontroller] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xexchumcallroutersettings)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xexchumcallroutersettings)
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

  end
end
