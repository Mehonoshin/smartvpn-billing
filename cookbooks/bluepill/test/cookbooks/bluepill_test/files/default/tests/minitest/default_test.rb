require_relative "./support/helpers"

describe_recipe 'bluepill_test::default' do
  include BluepillTestHelpers

  describe "create a bluepill configuration file" do
    let(:config) { file(::File.join(node['bluepill']['conf_dir'],
                                    node['bluepill_test']['service_name'] +
                                    ".pill")) }
    it { config.must_exist }

    it "must be valid ruby" do
      assert(shell_out("ruby -c #{config.path}").exitstatus == 0)
    end
  end

  describe "runs the application as a service" do
    let(:service) { bluepill_service(node['bluepill_test']['service_name']) }
    it { service.must_be_enabled }
    it { service.must_be_running }
  end

  it "the default log file must exist (COOK-1295)" do
    file(node['bluepill']['logfile']).must_exist
  end

  describe "spawn a netcat tcp client repeatedly" do
    let(:port) { node['bluepill_test']['tcp_server_listen_port'] }
    let(:secret) { node['bluepill_test']['secret'] }
    it "should receive a TCP connection from netcat" do
      TCPServer.open("localhost", port) do |server|
        client = server.accept
        assert_instance_of TCPSocket, client

        client_secret = client.gets.strip!
        assert_equal secret, client_secret

        client.close
      end
    end
  end
end
