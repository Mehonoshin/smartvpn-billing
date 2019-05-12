# frozen_string_literal: true

FactoryBot.define do
  sequence(:option_code) { |n| "option#{n}" }

  factory :option do
    name { 'I2P' }
    code { generate(:option_code) }
  end

  factory :active_option, parent: :option do
    state { 'active' }
  end

  factory :proxy_option, parent: :option do
    state { 'active' }
    code { 'proxy' }
    name { 'Proxy' }
  end

  factory :i2p_option, parent: :option do
    state { 'active' }
    code { 'i2p' }
    name { 'I2p' }
  end
end
