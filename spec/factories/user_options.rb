# frozen_string_literal: true

FactoryBot.define do
  factory :user_option do
    user_id { 1 }
    option_id { 1 }
    attrs { '' }

    trait :disabled do
      state { 'disabled' }
    end
  end
end
