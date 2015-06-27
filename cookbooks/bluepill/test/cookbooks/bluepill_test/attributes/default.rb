require 'securerandom'

default['bluepill_test']['service_name'] = "test_app"
default['bluepill_test']['tcp_server_listen_port'] = 1234
default['bluepill_test']['secret'] = SecureRandom.uuid
