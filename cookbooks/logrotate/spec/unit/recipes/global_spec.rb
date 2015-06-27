require 'spec_helper'

describe 'logrotate::global' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge(described_recipe) }

  it 'includes the default recipe' do
    expect(chef_run).to include_recipe('logrotate::default')
  end

  it 'writes the configuration template' do
    template = chef_run.template('/etc/logrotate.conf')
    expect(template).to be
    expect(template.source).to eq('logrotate-global.erb')
    expect(template.mode).to eq('0644')
  end
end
