require 'spec_helper'

describe 'tpm::pkcs11' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|

      it { is_expected.to create_class('tpm::pkcs11') }
      it { is_expected.to create_package('opencryptoki') }
      it { is_expected.to create_package('opencryptoki-tpmtok') }
      it { is_expected.to create_package('tpm-tools-pkcs11') }
      it { is_expected.to create_service('pkcsslotd').with({
        :ensure => 'running',
        :enable => true
      }) }

    end
  end

end