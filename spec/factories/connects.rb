# frozen_string_literal: true

FactoryBot.define do
  factory :connect do
    user
    server
    option_attributes { Hash[] }
  end
end
