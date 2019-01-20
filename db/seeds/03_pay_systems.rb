puts '##################################'
puts 'Create default pay systems'
puts '----------------------------------'

DEFAULT_PAY_SYSTEMS = [
  { name: 'Webmoney WMZ', code: 'wmz', description: '' },
  { name: 'Webmoney WMR', code: 'wmr', description: '' },
  { name: 'Яндекс.Деньги', code: 'yandex', description: '' },
  { name: 'PayPal', code: 'paypal', description: '' },
  { name: 'Visa/Mastercard', code: 'cc', description: '' }
].freeze

DEFAULT_PAY_SYSTEMS.each do |pay_system_params|
  PaySystem.where(name: pay_system_params[:name]).first_or_create!(pay_system_params)
  puts "Was find or created pay system #{pay_system_params[:name]}"
  puts '----------------------------------' unless pay_system_params[:name] == 'Visa/Mastercard'
end
