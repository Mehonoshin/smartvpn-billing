if user.connects.count.zero?
  puts '##################################'
  puts 'Create 20 test connections and disconnects to the main server for the default user'
  puts '----------------------------------'
  20.times do
    FactoryBot.create(:connect, user: user, server: main_server)
    FactoryBot.create(:disconnect, user: user, server: main_server)
  end
end

puts '##################################'
