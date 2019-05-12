# frozen_string_literal: true

FactoryBot.define do
  factory :proxy_connect, class: 'Proxy::Connect' do
    user_id { 1 }
    proxy_id { 1 }
  end
end
