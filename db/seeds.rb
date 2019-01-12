i2p = Option.create!(name: 'I2p', code: 'i2p', state: 'active')
proxy = Option.create!(name: 'Proxy', code: 'proxy', state: 'active')

plan = FactoryGirl.create(:plan, name: 'Стандарт', code: 'basic')
FactoryGirl.create(:plan, name: 'Стандарт Акция', code: 'basic_promo')

plan.options << i2p
plan.options << proxy
plan.update(option_prices: { 'i2p' => 0, 'proxy' => 0 })

FactoryGirl.create(:pay_system, name: 'Webmoney WMZ', code: 'wmz', description: '')
FactoryGirl.create(:pay_system, name: 'Webmoney WMR', code: 'wmr', description: '')
FactoryGirl.create(:pay_system, name: 'Яндекс.Деньги', code: 'yandex', description: '')
FactoryGirl.create(:pay_system, name: 'PayPal', code: 'paypal', description: '')
FactoryGirl.create(:pay_system, name: 'Visa/Mastercard', code: 'cc', description: '')

user = User.create!(email: 'user@smartvpn.biz', password: '1234567', plan: plan, balance: 100)
user.confirm
5.times do |i|
  referral = user.referrals.create!(email: "referral-#{i}@smartvpn.biz", password: '1234567', plan: plan, balance: 100)
  operation = referral.withdrawals.create!(amount: 10, plan_id: plan.id)
  Referrer::Reward.create!(
    referrer_id: referral.referrer_id,
    amount: (10 + i),
    operation_id: operation.id)
end

PaySystem.all.each do |ps|
  FactoryGirl.create(:payment, user: user, pay_system: ps).accept!
end
2.times { FactoryGirl.create(:withdrawal, plan: plan, user: user) }

Admin.create!(email: 'admin@smartvpn.biz', password: '1234567')

5.times do
  server = FactoryGirl.create(:server)
  server.plans << plan
end
server = FactoryGirl.create(:server, hostname: 'test.smartvpn.biz', ip_address: '192.168.33.10', state: 'active')
server.plans << plan
server.update(auth_key: 'VWHMTVRO')

20.times do
  FactoryGirl.create(:connect, user: user, server: server)
  FactoryGirl.create(:disconnect, user: user, server: server)
end
