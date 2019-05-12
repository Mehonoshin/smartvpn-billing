# frozen_string_literal: true

FactoryBot.define do
  factory :withdrawal do
    plan
    association :user, factory: :user_with_balance
    amount { 1 }
  end
end
