# frozen_string_literal: true

FactoryBot.define do
  factory :disconnect do
    user
    server
    traffic_in { 1.5 }
    traffic_out { 1.5 }
    option_attributes { Hash[] }
  end
end
