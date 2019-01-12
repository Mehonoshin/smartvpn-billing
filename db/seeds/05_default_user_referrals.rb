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

  referral_params = { email: "referral-#{i}@smartvpn.biz", password: '1234567', plan: standard_plan, balance: 100 }
  referral = user.referrals.create!(referral_params)
  operation = referral.withdrawals.create!(amount: 10, plan_id: standard_plan.id)
  Referrer::Reward.create!(
    referrer_id: referral.referrer_id,
    amount: (10 + i),
    operation_id: operation.id
  )
  puts "Was created default user referral #{referral.email}"
  puts '----------------------------------' unless i == 4
end
