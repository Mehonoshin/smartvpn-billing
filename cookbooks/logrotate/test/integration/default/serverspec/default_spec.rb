require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'logrotate::default' do
  describe package('logrotate') do
    it { should be_installed }
  end
end
