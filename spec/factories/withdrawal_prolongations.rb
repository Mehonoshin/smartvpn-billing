# frozen_string_literal: true

FactoryGirl.define do
  factory :withdrawal_prolongation do
    withdrawal
    days_number 1
  end
end