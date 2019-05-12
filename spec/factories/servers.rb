# frozen_string_literal: true

FactoryBot.define do
  sequence(:server_hostname) { |n| "#{Faker::Lorem.word}#{n}" }

  factory :server do
    hostname { generate(:server_hostname) }
    ip_address { '192.168.1.1' }
    protocol { 'udp' }
    port { 443 }
    server_crt { 'some server crt' }
    client_crt { 'some client crt' }
    client_key { 'some client key' }
  end

  factory :disabled_server, parent: :server do
    state { :disabled }
  end

  factory :active_server, parent: :server do
    state { :active }
  end
end
