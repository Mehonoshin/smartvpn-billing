# frozen_string_literal: true

FactoryGirl.define do
  factory :payment do
    user
    amount 10
    association :pay_system, factory: :enabled_pay_system
  end
end
