require 'spec_helper'

describe Puppet::Type.type(:tpm_ownership) do

  before :each do
    Facter.stubs(:value).with(:has_tpm).returns(false)
  end

  context 'pre_run_check' do
    skip('TODO: figure out how to read this function from rspec')
    it 'should fail to run on a host without a TPM' do
      expect {
        Puppet::Type.type(:tpm_ownership).new(
          :name           => 'tpm0',
          :owner_pass     => 'badpass',
          :srk_pass       => 'badpass',
        ).pre_run_check
      }.to raise_error(/Host doesn't have a TPM/)
    end
  end

  context 'should require a boolean for advanced_facts' do
    it 'is given a boolean' do
      expect {
        Puppet::Type.type(:tpm_ownership).new(
          :name           => 'tpm0',
          :owner_pass     => 'badpass',
          :srk_pass       => 'badpass',
          :advanced_facts => true
        )
      }.to_not raise_error
    end
    it 'is given a string that is not a boolean' do
      expect {
        Puppet::Type.type(:tpm_ownership).new(
          :name           => 'tpm0',
          :owner_pass     => 'badpass',
          :srk_pass       => 'badpass',
          :advanced_facts => 'not a boolean'
        )
      }.to raise_error
    end
  end

  it 'should fail to run without the owner_pass field' do
    expect {
      Puppet::Type.type(:tpm_ownership).new(
        :name => 'tpm0',
      )
    }.to raise_error(Puppet::ResourceError)
  end

  [:owner_pass, :srk_pass].each do |param|
    it "should require a string for #{param}" do
      expect {
        Puppet::Type.type(:tpm_ownership).new(
          :name => 'tpm0',
          param => ['array','should','fail']
        )
      }.to raise_error(/#{param.to_s} must be a String/)
    end
  end
end
