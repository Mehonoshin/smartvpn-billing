# frozen_string_literal: true

FactoryGirl.define do
  factory :plan do
    name 'Tariff plan plus'
    price 10
    description 'MyText'
    code 'plus'
    special false
    enabled true
  end
end