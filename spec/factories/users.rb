# frozen_string_literal: true

FactoryBot.define do
  sequence(:user_email)    { |n| "person#{n}@example.com" }
  sequence(:user_password) { |_n| 'password' }

  factory :user do
    plan
    email { generate(:user_email) }
    password { generate(:user_password) }
    accept_agreement { '1' }
    confirmed_at { Time.current }
  end

  factory :user_with_balance, parent: :user do
    balance { 100 }
  end
end
