require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
describe "redis" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "redis information is available" do
    redis_info = shell_out "redis-cli info"
    redis_info.stdout.must_match(/redis_version/)
  end
end

