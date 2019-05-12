puts '##################################'
puts 'Create default user'
puts '----------------------------------'

def user
  @user ||= User
            .where(email: 'user@smartvpn.biz')
            .first_or_create!(password: '1234567', plan: standard_plan, balance: 100)
end

user.confirm unless user.confirmed?

puts "Was find or created default user - email: #{user.email}, password: 1234567 and activated"

if user.payments.count.zero?
  puts '##################################'
  puts 'Create default user payments'
  puts '----------------------------------'
  last_pay_system = PaySystem.last
  PaySystem.all.each do |pay_system|
    FactoryBot.create(:payment, user: user, pay_system: pay_system).accept!
    puts "Was created default user payment for pay system #{pay_system.name}"
    puts '----------------------------------' unless pay_system.name == last_pay_system.name
  end
end

if user.withdrawals.count.zero?
  puts '##################################'
  puts 'Create default user two tests withdrawals'
  puts '----------------------------------'
  2.times { FactoryBot.create(:withdrawal, plan: standard_plan, user: user) }
end
