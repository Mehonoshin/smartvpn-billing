require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'logrotate::default' do
  describe file('/etc/logrotate.d/tomcat-myapp') do
    it { should be_a_file }
    it { should be_mode(440) }
    it do
      should contain %q(
        "/var/log/tomcat/myapp.log" {
          daily
          rotate 30
          create 644 root adm
        }
      )
    end
  end

  describe file('/etc/logrotate.d/tomcat-myapp-multi-path') do
    it { should be_a_file }
    it { should be_mode(440) }
    it do
      should contain %q(
        "/var/log/tomcat/myapp.log" "/opt/local/tomcat/catalina.out" {
          daily
          rotate 7
          create 644 root adm
      )
    end
  end

  describe file('/etc/logrotate.d/tomcat-myapp-no-enable') do
    it { should_not be_a_file }
  end

  describe file('/etc/logrotate.d/tomcat-myapp-alt-cookbook') do
    it { should be_a_file }
    it { should be_mode(440) }
    it { should contain('# This is a different template') }
  end

  describe file('/etc/logrotate.d/tomcat-myapp-custom-options') do
    it { should be_a_file }
    it { should be_mode(440) }
    it do
      should contain %q(
        missingok
        delaycompress
        firstaction
      )
    end
  end
end
