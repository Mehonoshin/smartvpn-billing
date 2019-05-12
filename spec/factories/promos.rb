# frozen_string_literal: true

FactoryBot.define do
  factory :promo do
    name { 'Promo name' }
    type { 'withdrawal' }
    date_from { 2.day.ago }
    date_to { 2.day.from_now }
    promoter_type { 'discount' }
    promo_code { 'MyString' }
  end

  factory :active_promo, parent: :promo do
    state { 'active' }
  end

  factory :option_promo, parent: :promo do
    type { 'option' }
  end
end
