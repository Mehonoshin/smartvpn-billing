require 'spec_helper'

describe 'debian::default' do
  context 'on Debian' do
    subject do
      debian_runner('6.0.5') do |node|
        node.automatic_attrs['lsb'] = { 'codename' => 'cheese' }
      end.converge 'debian::default'
    end

    it { should include_recipe 'apt' }
    xit { should run_execute 'apt-get update' }
    it { should add_apt_source 'deb http://http.debian.net/debian cheese main contrib non-free' }
    it { should include_recipe 'debian::security' }
    it { should_not include_recipe 'debian::testing' }

    context 'without lsb-release' do
      context 'with first release version' do
        subject do
          debian_runner('7.0') do |node|
            node.automatic_attrs['lsb'] = {}
            node.automatic_attrs['platform_version'] = '7.0'
          end.converge 'debian::default'
        end

        it { should add_apt_source 'deb http://http.debian.net/debian wheezy main contrib non-free' }
      end

      context 'with a point release' do
        subject do
          debian_runner('7.0') do |node|
            node.automatic_attrs['lsb'] = {}
            node.automatic_attrs['platform_version'] = '7.1'
          end.converge 'debian::default'
        end

        it { should add_apt_source 'deb http://http.debian.net/debian wheezy main contrib non-free' }
      end
    end

    context 'with specified node attributes' do
      subject do
        debian_runner('7.0') do |node|
          node.automatic_attrs['lsb'] = { 'codename' => 'cheese' }
          node.set['debian']['mirror']     = 'http://example.com/debian-mirror'
          node.set['debian']['components'] = %w[resistor diode]
          node.set['debian']['deb_src']    = true
          node.set['debian']['backports']  = true
        end.converge 'debian::default'
      end

      it { should add_apt_source 'deb http://example.com/debian-mirror cheese resistor diode'; subject }
      it { should add_apt_source 'deb-src http://example.com/debian-mirror cheese resistor diode' }
      it { should include_recipe 'debian::backports' }
    end
  end

  context 'on non-Debian' do
    subject do
      ChefSpec::Runner.new(
        platform: 'ubuntu', version: '12.04',
        log_level: :error
      ).converge 'debian::default'
    end

    it 'warns' do
      Chef::Log.should_receive(:warn).with('recipe[debian::default] included in non-Debian platform. Skipping.')
      should be
    end
    it { should_not include_recipe 'apt' }
    it { should_not create_file '/etc/apt/sources.list' }
  end
end
