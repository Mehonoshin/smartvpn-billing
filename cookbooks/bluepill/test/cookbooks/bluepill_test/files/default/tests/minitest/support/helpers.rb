require 'chef/mixin/shell_out'

module BluepillTestHelpers
  include Chef::Mixin::ShellOut

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  MiniTest::Chef::Resources.register_resource(:bluepill_service)
  MiniTest::Chef::Infections.infect_resource(:bluepill_service, :enabled, :be_enabled)
  MiniTest::Chef::Infections.infect_resource(:bluepill_service, :running, :be_running)
end
