# frozen_string_literal: true

FactoryGirl.define do
  factory :connect do
    user
    server
    option_attributes Hash[]
  end
end