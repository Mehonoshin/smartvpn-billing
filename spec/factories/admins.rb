# frozen_string_literal: true

FactoryBot.define do
  sequence(:admin_email)    { |n| "admin#{n}@example.com" }
  sequence(:admin_password) { |n| "password#{n}" }

  factory :admin do
    email { generate(:admin_email) }
    password { generate(:admin_password) }
  end
end
