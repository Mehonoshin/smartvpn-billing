# frozen_string_literal: true

FactoryGirl.define do
  factory :referrer_reward, class: 'Referrer::Reward' do
    amount '9.99'
    operation_id 1
    referrer_id 1
  end
end