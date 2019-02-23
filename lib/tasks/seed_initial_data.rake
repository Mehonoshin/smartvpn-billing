# frozen_string_literal: true

namespace :smartvpn do
  namespace :initial_data do
    desc 'Seed initial data if needed'
    task seed: :environment do
      Admin.create!(email: 'admin@smartvpn.biz', password: '') if Admin.all.empty?

      basic_plan = Plan.where(code: 'basic').last
      basic_plan ||= Plan.create!(name: 'Basic', price: 1.28, description: 'Basic plan', code: 'basic')

      promo_plan = Plan.where(code: 'basic_promo').last
      unless promo_plan
        Plan.create!(name: 'Стандарт Акция', price: 3.84, description: 'Promo basic plan', code: 'basic_promo')
      end

      friends_plan = Plan.where(code: 'zero').last
      unless friends_plan
        Plan.create!(name: 'Zero', price: 0, special: true, description: 'Basic plan with zero price', code: 'zero')
      end

      basic_plan.update(price: 1.28, name: 'Стандарт')
      promo_plan.update(price: 3.84)

      Plan.update_all('enabled=true')

      { 'yandex' => 'Яндекс.Деньги', 'wmz' => 'Webmoney WMZ', 'wmr' => 'Webmoney WMR',
        'paypal' => 'PayPal', 'cc' => 'Visa/MasterCard' }.each do |code, name|
        PaySystem.find_or_create_by!(code: code) do |ps|
          ps.name = name
        end
      end
    end
  end
end
