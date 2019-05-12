# frozen_string_literal: true

FactoryBot.define do
  factory :plan_has_server do
    server
    plan
  end
end
