require 'spec_helper'

describe 'rsyslog::server' do
  let(:chef_run) do
    ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['rsyslog']['server'] = false
    end.converge('rsyslog::server')
  end

  let(:service_resource) { 'service[rsyslog]' }

  it "sets node['rsyslog']['server'] to true" do
    expect(chef_run.node['rsyslog']['server']).to be_true
  end

  it 'includes the default recipe' do
    expect(chef_run).to include_recipe('rsyslog::default')
  end

  context '/srv/rsyslog directory' do
    let(:directory) { chef_run.directory('/srv/rsyslog') }

    it 'creates the directory' do
      expect(chef_run).to create_directory('/srv/rsyslog')
    end

    it 'is owned by root:root' do
      expect(directory.owner).to eq('root')
      expect(directory.group).to eq('root')
    end

    it 'has 0755 permissions' do
      expect(directory.mode).to eq('0755')
    end
  end

  context '/etc/rsyslog.d/35-server-per-host.conf template' do
    let(:template) { chef_run.template('/etc/rsyslog.d/35-server-per-host.conf') }

    it 'creates the template' do
      expect(chef_run).to create_file_with_content(template.path, '/srv/rsyslog/%$YEAR%/%$MONTH%/%$DAY%/%HOSTNAME%/auth.log')
    end

    it 'is owned by root:root' do
      expect(template.owner).to eq('root')
      expect(template.group).to eq('root')
    end

    it 'has 0644 permissions' do
      expect(template.mode).to eq('0644')
    end

    it 'notifies restarting the service' do
      expect(template).to notify(service_resource, :restart)
    end

    context 'on SmartOS' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(platform: 'smartos', version: 'joyent_20130111T180733Z') do |node|
          node.set['rsyslog']['server'] = false
        end.converge('rsyslog::server')
      end

      let(:template) { chef_run.template('/opt/local/etc/rsyslog.d/35-server-per-host.conf') }

      it 'creates the template' do
        expect(chef_run).to create_file_with_content(template.path, '/srv/rsyslog/%$YEAR%/%$MONTH%/%$DAY%/%HOSTNAME%/auth.log')
      end

      it 'is owned by root:root' do
        expect(template.owner).to eq('root')
        expect(template.group).to eq('root')
      end

      it 'has 0644 permissions' do
        expect(template.mode).to eq('0644')
      end

      it 'notifies restarting the service' do
        expect(template).to notify(service_resource, :restart)
      end
    end
  end

  context '/etc/rsyslog.d/remote.conf file' do
    let(:file) { chef_run.file('/etc/rsyslog.d/remote.conf') }

    it 'deletes the file' do
      expect(chef_run).to delete_file(file.path)
    end

    it 'notifies restarting the service' do
      expect(file).to notify(service_resource, :reload)
    end

    context 'on SmartOS' do
      let(:chef_run) do
        ChefSpec::ChefRunner.new(platform: 'smartos', version: 'joyent_20130111T180733Z') do |node|
          node.set['rsyslog']['server'] = false
        end.converge('rsyslog::server')
      end

      let(:file) { chef_run.file('/opt/local/etc/rsyslog.d/remote.conf') }

      it 'deletes the file' do
        expect(chef_run).to delete_file(file.path)
      end

      it 'notifies restarting the service' do
        expect(file).to notify(service_resource, :reload)
      end
    end
  end
end
