puts '##################################'
puts 'Create options for plans'
puts '----------------------------------'
i2p = Option.where(name: 'I2p').first_or_create(name: 'I2p', code: 'i2p', state: 'active')
puts "Was find or created option #{i2p.name}"
puts '----------------------------------'
proxy = Option.where(name: 'Proxy').first_or_create(name: 'Proxy', code: 'proxy', state: 'active')
puts "Was find or created option #{proxy.name}"

puts '##################################'
puts 'Create default plans'
puts '----------------------------------'
plan_default_params = { price: 10, description: 'MyText', special: false, enabled: true }
standard_plan = Plan.where(name: 'Стандарт').first_or_create({ name: 'Стандарт', code: 'basic' }.merge(plan_default_params))
puts 'Was find or created standard plan'
puts '----------------------------------'
Plan.where(name: 'Стандарт Акция').first_or_create({ name: 'Стандарт Акция', code: 'basic_promo' }.merge(plan_default_params))
puts 'Was find or created standard stock plan'

puts '##################################'
puts 'Update standard plan options'
puts '----------------------------------'
standard_plan.options << i2p unless standard_plan.options.include?(i2p)
puts 'Added i2p option to standard plan if not exists'
puts '----------------------------------'
standard_plan.options << proxy unless standard_plan.options.include?(proxy)
puts 'Added proxy option to standard plan if not exists'
puts '----------------------------------'
standard_plan.update(option_prices: { 'i2p' => 0, 'proxy' => 0 })
puts 'Updated standard plan options price to 0'

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
  PaySystem.where(name: pay_system_params[:name]).first_or_create(pay_system_params)
  puts "Was find or created pay system #{pay_system_params[:name]}"
  puts '----------------------------------' unless pay_system_params[:name] == 'Visa/Mastercard'
end

puts '##################################'
puts 'Create default user'
puts '----------------------------------'
user = User.where(email: 'user@smartvpn.biz').first_or_create(email: 'user@smartvpn.biz', password: '1234567', plan: standard_plan, balance: 100)
user.confirm
puts "Was find or created default user - email: #{user.email}, password: 1234567 and activated"

puts '##################################'
puts 'Create test default user referrals'
puts '----------------------------------'
5.times do |i|
  referral = user.referrals.find_by(email: "referral-#{i}@smartvpn.biz")
  if referral
    puts "Was found default user referral #{referral.email}"
    puts '----------------------------------' unless i == 4
    next
  end

  referral = user.referrals.create!(email: "referral-#{i}@smartvpn.biz", password: '1234567', plan: standard_plan, balance: 100)
  operation = referral.withdrawals.create!(amount: 10, plan_id: standard_plan.id)
  Referrer::Reward.create!(
    referrer_id: referral.referrer_id,
    amount: (10 + i),
    operation_id: operation.id
  )
  puts "Was created default user referral #{referral.email}"
  puts '----------------------------------' unless i == 4
end

if user.payments.count.zero?
  puts '##################################'
  puts 'Create default user payments'
  puts '----------------------------------'
  last_pay_system = PaySystem.last
  PaySystem.all.each do |pay_system|
    FactoryGirl.create(:payment, user: user, pay_system: pay_system).accept!
    puts "Was created default user payment for pay system #{pay_system.name}"
    puts '----------------------------------' unless pay_system.name == last_pay_system.name
  end
end

if user.withdrawals.count.zero?
  puts '##################################'
  puts 'Create default user two tests withdrawals'
  puts '----------------------------------'
  2.times { FactoryGirl.create(:withdrawal, plan: standard_plan, user: user) }
end

puts '##################################'
puts 'Create admin user'
puts '----------------------------------'
Admin.where(email: 'admin@smartvpn.biz').first_or_create(email: 'admin@smartvpn.biz', password: '1234567')
puts 'Was find or created admin user - email: useradmin@smartvpn.biz, password: 1234567'

if Server.count.zero?
  puts '##################################'
  puts 'Create tests servers'
  puts '----------------------------------'
  5.times do |i|
    server = FactoryGirl.create(:server)
    server.plans << standard_plan
    puts "Was created test server hostname: #{server.hostname} with standard plan"
    puts '----------------------------------' unless i == 4
  end
end

puts '##################################'
puts 'Create main server'
puts '----------------------------------'
server = Server.find_by(hostname: 'test.smartvpn.biz')
if server
  puts "Was found server hostname: #{server.hostname}"
else
  server = FactoryGirl.create(:server, hostname: 'test.smartvpn.biz', ip_address: '192.168.33.10', state: 'active')
  server.plans << standard_plan
  server.update(auth_key: 'VWHMTVRO')
  puts "Was created main test server hostname: #{server.hostname} with standard plan and auth key VWHMTVRO"
end

if user.connects.count.zero?
  puts '##################################'
  puts 'Create 20 test connections and disconnects to the server for the default user'
  puts '----------------------------------'
  20.times do
    FactoryGirl.create(:connect, user: user, server: server)
    FactoryGirl.create(:disconnect, user: user, server: server)
  end
end
puts '##################################'
