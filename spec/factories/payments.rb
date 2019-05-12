# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    user
    amount { 10 }
    association :pay_system, factory: :enabled_pay_system
  end
end
