puts '##################################'
puts 'Create admin user'
puts '----------------------------------'

Admin.where(email: 'admin@smartvpn.biz').first_or_create!(password: '1234567')

puts 'Was find or created admin user - email: admin@smartvpn.biz, password: 1234567'
