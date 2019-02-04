# TODO:
# devide factories by subsystems
# e.g.:
# spec/factories/proxy
# spec/factories/payments
# spec/factories/users
# spec/factories/partner_program

FactoryGirl.define do
  factory :admin do
    sequence(:email)               {|n| "admin#{n}@example.com"}
    sequence(:password)            {|n| "password#{n}"}
  end

  factory :user do
    sequence(:email)               {|n| "person#{n}@example.com"}
    sequence(:password)            {|n| "password"}
    plan
    accept_agreement "1"
    confirmed_at Time.current

    factory :user_with_balance do
      balance 100
    end
  end

  factory :plan do
    name "Tariff plan plus"
    price 10
    description "MyText"
    code "plus"
    special false
    enabled true
  end

  factory :payment do
    user
    amount 10
    association :pay_system, factory: :enabled_pay_system
  end

  factory :pay_system do
    sequence(:name) {|n| "PaySystem#{n}"}
    sequence(:code) {|n| "code#{n}"}

    factory :enabled_pay_system do
      state :enabled
    end

    factory :rub_pay_system do
      state :enabled
      currency 'rub'
    end
  end

  factory :withdrawal do
    plan
    association :user, factory: :user_with_balance
    amount 1
  end

  factory :withdrawal_prolongation do
    withdrawal
    days_number 1
  end

  factory :server do
    sequence(:hostname) { |n| "#{Faker::Lorem.word}#{n}" }
    ip_address "192.168.1.1"
    protocol 'udp'
    port 443
    server_crt 'some server crt'
    client_crt 'some client crt'
    client_key 'some client key'

    factory :disabled_server do
      state :disabled
    end

    factory :active_server do
      state :active
    end
  end

  factory :connect do
    user
    server
    option_attributes Hash[]
  end

  factory :disconnect do
    user
    server
    traffic_in 1.5
    traffic_out 1.5
    option_attributes Hash[]
  end

  factory :plan_has_server do
    server
    plan
  end

  factory :promo do
    name "Promo name"
    type "withdrawal"
    date_from 2.day.ago
    date_to 2.day.from_now
    promoter_type "discount"
    promo_code "MyString"

    factory :active_promo do
      state 'active'
    end

    factory :option_promo do
      type "option"
    end
  end

  factory :promotion do
    user_id 1
    promo_id 1
  end

  factory :option do
    name "I2P"
    sequence(:code) {|n| "option#{n}"}

    factory :active_option do
      state 'active'
    end

    factory :proxy_option do
      state 'active'
      code 'proxy'
      name 'Proxy'
    end

    factory :i2p_option do
      state 'active'
      code 'i2p'
      name 'I2p'
    end
  end

  factory :referrer_reward, :class => 'Referrer::Reward' do
    amount "9.99"
    operation_id 1
    referrer_id 1
  end

  factory :proxy_connect, :class => 'Proxy::Connect' do
    user_id 1
    proxy_id 1
  end

  factory :proxy_node, :class => 'Proxy::Node' do
    host "MyString"
    port 1
    country "MyString"
    location "MyString"
    ping 1
    bandwidth 1
    protocol "MyString"
    anonymity "MyString"
  end

  factory :user_option do
    user_id 1
    option_id 1
    attrs ""

    trait :disabled do
      state 'disabled'
    end
  end

end
