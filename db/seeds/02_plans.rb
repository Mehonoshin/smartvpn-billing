puts '##################################'
puts 'Create default plans'
puts '----------------------------------'

def plan_params(merge_params)
  { price: 10, description: 'MyText', special: false, enabled: true }.merge(merge_params)
end

def standard_plan
  @standard_plan ||= Plan.where(name: 'Стандарт').first_or_create!(plan_params(code: 'basic'))
end

standard_plan

puts 'Was find or created standard plan'
puts '----------------------------------'

Plan.where(name: 'Стандарт Акция').first_or_create!(plan_params(code: 'basic_promo'))

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
