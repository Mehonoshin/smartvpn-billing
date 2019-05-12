# frozen_string_literal: true

FactoryBot.define do
  factory :proxy_node, class: 'Proxy::Node' do
    host { 'MyString' }
    port { 1 }
    country { 'MyString' }
    location { 'MyString' }
    ping { 1 }
    bandwidth { 1 }
    protocol { 'MyString' }
    anonymity { 'MyString' }
  end
end
