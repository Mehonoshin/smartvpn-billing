# frozen_string_literal: true

FactoryBot.define do
  sequence(:name) { |n| "PaySystem#{n}" }
  sequence(:code) { |n| "code#{n}" }

  factory :pay_system do
    name { generate(:name) }
    code { generate(:code) }
  end

  factory :enabled_pay_system, parent: :pay_system do
    state { :enabled }
  end

  factory :rub_pay_system, parent: :pay_system do
    state { :enabled }
    currency { 'rub' }
  end
end
