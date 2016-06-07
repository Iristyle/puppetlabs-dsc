#!/usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:dsc_xspsearchcrawlrule) do

  let :dsc_xspsearchcrawlrule do
    Puppet::Type.type(:dsc_xspsearchcrawlrule).new(
      :name     => 'foo',
      :dsc_path => 'foo',
    )
  end

  it 'should allow all properties to be specified' do
    expect { Puppet::Type.type(:dsc_xspsearchcrawlrule).new(
      :name     => 'foo',
      :dsc_path => 'foo',
      :dsc_serviceappname => 'foo',
      :dsc_authenticationtype => 'DefaultRuleAccess',
      :dsc_ruletype => 'InclusionRule',
      :dsc_crawlconfigurationrules => 'FollowLinksNoPageCrawl',
      :dsc_authenticationcredentials => {"user"=>"user", "password"=>"password"},
      :dsc_certificatename => 'foo',
      :dsc_ensure => 'Present',
      :dsc_installaccount => {"user"=>"user", "password"=>"password"},
    )}.to_not raise_error
  end

  it "should stringify normally" do
    expect(dsc_xspsearchcrawlrule.to_s).to eq("Dsc_xspsearchcrawlrule[foo]")
  end

  it 'should default to ensure => present' do
    expect(dsc_xspsearchcrawlrule[:ensure]).to eq :present
  end

  it 'should require that dsc_path is specified' do
    #dsc_xspsearchcrawlrule[:dsc_path]
    expect { Puppet::Type.type(:dsc_xspsearchcrawlrule).new(
      :name     => 'foo',
    )}.to raise_error(Puppet::Error, /dsc_path is a required attribute/)
  end

  it 'should not accept array for dsc_path' do
    expect{dsc_xspsearchcrawlrule[:dsc_path] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_path' do
    expect{dsc_xspsearchcrawlrule[:dsc_path] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_path' do
    expect{dsc_xspsearchcrawlrule[:dsc_path] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_path' do
    expect{dsc_xspsearchcrawlrule[:dsc_path] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_serviceappname' do
    expect{dsc_xspsearchcrawlrule[:dsc_serviceappname] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_serviceappname' do
    expect{dsc_xspsearchcrawlrule[:dsc_serviceappname] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_serviceappname' do
    expect{dsc_xspsearchcrawlrule[:dsc_serviceappname] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_serviceappname' do
    expect{dsc_xspsearchcrawlrule[:dsc_serviceappname] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_authenticationtype predefined value DefaultRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'DefaultRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('DefaultRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value defaultruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'defaultruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('defaultruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value BasicAccountRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'BasicAccountRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('BasicAccountRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value basicaccountruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'basicaccountruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('basicaccountruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value CertificateRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'CertificateRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('CertificateRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value certificateruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'certificateruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('certificateruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value NTLMAccountRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'NTLMAccountRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('NTLMAccountRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value ntlmaccountruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'ntlmaccountruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('ntlmaccountruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value FormRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'FormRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('FormRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value formruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'formruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('formruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value CookieRuleAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'CookieRuleAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('CookieRuleAccess')
  end

  it 'should accept dsc_authenticationtype predefined value cookieruleaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'cookieruleaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('cookieruleaccess')
  end

  it 'should accept dsc_authenticationtype predefined value AnonymousAccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'AnonymousAccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('AnonymousAccess')
  end

  it 'should accept dsc_authenticationtype predefined value anonymousaccess' do
    dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'anonymousaccess'
    expect(dsc_xspsearchcrawlrule[:dsc_authenticationtype]).to eq('anonymousaccess')
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_authenticationtype' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationtype] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_authenticationtype' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationtype] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_authenticationtype' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationtype] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_authenticationtype' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationtype] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_ruletype predefined value InclusionRule' do
    dsc_xspsearchcrawlrule[:dsc_ruletype] = 'InclusionRule'
    expect(dsc_xspsearchcrawlrule[:dsc_ruletype]).to eq('InclusionRule')
  end

  it 'should accept dsc_ruletype predefined value inclusionrule' do
    dsc_xspsearchcrawlrule[:dsc_ruletype] = 'inclusionrule'
    expect(dsc_xspsearchcrawlrule[:dsc_ruletype]).to eq('inclusionrule')
  end

  it 'should accept dsc_ruletype predefined value ExclusionRule' do
    dsc_xspsearchcrawlrule[:dsc_ruletype] = 'ExclusionRule'
    expect(dsc_xspsearchcrawlrule[:dsc_ruletype]).to eq('ExclusionRule')
  end

  it 'should accept dsc_ruletype predefined value exclusionrule' do
    dsc_xspsearchcrawlrule[:dsc_ruletype] = 'exclusionrule'
    expect(dsc_xspsearchcrawlrule[:dsc_ruletype]).to eq('exclusionrule')
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xspsearchcrawlrule[:dsc_ruletype] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ruletype' do
    expect{dsc_xspsearchcrawlrule[:dsc_ruletype] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ruletype' do
    expect{dsc_xspsearchcrawlrule[:dsc_ruletype] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ruletype' do
    expect{dsc_xspsearchcrawlrule[:dsc_ruletype] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ruletype' do
    expect{dsc_xspsearchcrawlrule[:dsc_ruletype] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_crawlconfigurationrules predefined value FollowLinksNoPageCrawl' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'FollowLinksNoPageCrawl'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['FollowLinksNoPageCrawl'])
  end

  it 'should accept dsc_crawlconfigurationrules predefined value followlinksnopagecrawl' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'followlinksnopagecrawl'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['followlinksnopagecrawl'])
  end

  it 'should accept dsc_crawlconfigurationrules predefined value CrawlComplexUrls' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'CrawlComplexUrls'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['CrawlComplexUrls'])
  end

  it 'should accept dsc_crawlconfigurationrules predefined value crawlcomplexurls' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'crawlcomplexurls'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['crawlcomplexurls'])
  end

  it 'should accept dsc_crawlconfigurationrules predefined value CrawlAsHTTP' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'CrawlAsHTTP'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['CrawlAsHTTP'])
  end

  it 'should accept dsc_crawlconfigurationrules predefined value crawlashttp' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'crawlashttp'
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(['crawlashttp'])
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept array of predefined values for dsc_crawlconfigurationrules' do
    dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = ["FollowLinksNoPageCrawl", "CrawlComplexUrls", "CrawlAsHTTP"]
    expect(dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules]).to eq(["FollowLinksNoPageCrawl", "CrawlComplexUrls", "CrawlAsHTTP"])
  end

  it 'should not accept boolean for dsc_crawlconfigurationrules' do
    expect{dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_crawlconfigurationrules' do
    expect{dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_crawlconfigurationrules' do
    expect{dsc_xspsearchcrawlrule[:dsc_crawlconfigurationrules] = 16}.to raise_error(Puppet::ResourceError)
  end

  it "should not accept empty password for dsc_authenticationcredentials" do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationcredentials] = {"user"=>"user", "password"=>""}}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_authenticationcredentials' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationcredentials] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_authenticationcredentials' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationcredentials] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_authenticationcredentials' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationcredentials] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_authenticationcredentials' do
    expect{dsc_xspsearchcrawlrule[:dsc_authenticationcredentials] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_certificatename' do
    expect{dsc_xspsearchcrawlrule[:dsc_certificatename] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_certificatename' do
    expect{dsc_xspsearchcrawlrule[:dsc_certificatename] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_certificatename' do
    expect{dsc_xspsearchcrawlrule[:dsc_certificatename] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_certificatename' do
    expect{dsc_xspsearchcrawlrule[:dsc_certificatename] = 16}.to raise_error(Puppet::ResourceError)
  end

  it 'should accept dsc_ensure predefined value Present' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'Present'
    expect(dsc_xspsearchcrawlrule[:dsc_ensure]).to eq('Present')
  end

  it 'should accept dsc_ensure predefined value present' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'present'
    expect(dsc_xspsearchcrawlrule[:dsc_ensure]).to eq('present')
  end

  it 'should accept dsc_ensure predefined value present and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'present'
    expect(dsc_xspsearchcrawlrule[:ensure]).to eq(dsc_xspsearchcrawlrule[:dsc_ensure].downcase.to_sym)
  end

  it 'should accept dsc_ensure predefined value Absent' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'Absent'
    expect(dsc_xspsearchcrawlrule[:dsc_ensure]).to eq('Absent')
  end

  it 'should accept dsc_ensure predefined value absent' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'absent'
    expect(dsc_xspsearchcrawlrule[:dsc_ensure]).to eq('absent')
  end

  it 'should accept dsc_ensure predefined value absent and update ensure with this value (ensure end value should be a symbol)' do
    dsc_xspsearchcrawlrule[:dsc_ensure] = 'absent'
    expect(dsc_xspsearchcrawlrule[:ensure]).to eq(dsc_xspsearchcrawlrule[:dsc_ensure].downcase.to_sym)
  end

  it 'should not accept values not equal to predefined values' do
    expect{dsc_xspsearchcrawlrule[:dsc_ensure] = 'invalid value'}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_ensure' do
    expect{dsc_xspsearchcrawlrule[:dsc_ensure] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_ensure' do
    expect{dsc_xspsearchcrawlrule[:dsc_ensure] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_ensure' do
    expect{dsc_xspsearchcrawlrule[:dsc_ensure] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_ensure' do
    expect{dsc_xspsearchcrawlrule[:dsc_ensure] = 16}.to raise_error(Puppet::ResourceError)
  end

  it "should not accept empty password for dsc_installaccount" do
    expect{dsc_xspsearchcrawlrule[:dsc_installaccount] = {"user"=>"user", "password"=>""}}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept array for dsc_installaccount' do
    expect{dsc_xspsearchcrawlrule[:dsc_installaccount] = ["foo", "bar", "spec"]}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept boolean for dsc_installaccount' do
    expect{dsc_xspsearchcrawlrule[:dsc_installaccount] = true}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept int for dsc_installaccount' do
    expect{dsc_xspsearchcrawlrule[:dsc_installaccount] = -16}.to raise_error(Puppet::ResourceError)
  end

  it 'should not accept uint for dsc_installaccount' do
    expect{dsc_xspsearchcrawlrule[:dsc_installaccount] = 16}.to raise_error(Puppet::ResourceError)
  end

  # Configuration PROVIDER TESTS

  describe "powershell provider tests" do

    it "should successfully instanciate the provider" do
      described_class.provider(:powershell).new(dsc_xspsearchcrawlrule)
    end

    before(:each) do
      @provider = described_class.provider(:powershell).new(dsc_xspsearchcrawlrule)
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
        dsc_xspsearchcrawlrule.original_parameters[:dsc_ensure] = 'present'
        dsc_xspsearchcrawlrule[:dsc_ensure] = 'present'
        @provider = described_class.provider(:powershell).new(dsc_xspsearchcrawlrule)
      end

      it "should update :ensure to :present" do
        expect(dsc_xspsearchcrawlrule[:ensure]).to eq(:present)
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
        dsc_xspsearchcrawlrule.original_parameters[:dsc_ensure] = 'absent'
        dsc_xspsearchcrawlrule[:dsc_ensure] = 'absent'
        @provider = described_class.provider(:powershell).new(dsc_xspsearchcrawlrule)
      end

      it "should update :ensure to :absent" do
        expect(dsc_xspsearchcrawlrule[:ensure]).to eq(:absent)
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