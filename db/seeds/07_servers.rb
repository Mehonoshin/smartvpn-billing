if Server.count.zero?
  puts '##################################'
  puts 'Create tests servers'
  puts '----------------------------------'
  5.times do |i|
    server = FactoryBot.create(:server)
    server.plans << standard_plan
    puts "Was created test server hostname: #{server.hostname} with standard plan"
    puts '----------------------------------' unless i == 4
  end
end

puts '##################################'
puts 'Create main server'
puts '----------------------------------'

def main_server
  @main_server ||= Server
                   .where(hostname: 'test.smartvpn.biz')
                   .first_or_create!(ip_address: '192.168.33.10', state: 'active')
end

puts "Was found or created main server hostname: #{main_server.hostname}"
puts '----------------------------------'

if main_server.plans.count.zero?
  main_server.plans << standard_plan
  puts "Was added standard plan to main server hostname: #{main_server.hostname}"
  puts '----------------------------------'
end

main_server.update(auth_key: 'VWHMTVRO')
puts "Was updated auth key on main server hostname: #{main_server.hostname} to VWHMTVRO"
