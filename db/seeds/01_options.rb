puts '##################################'
puts 'Create options for plans'
puts '----------------------------------'

def i2p
  @i2p ||= Option.where(name: 'I2p').first_or_create(name: 'I2p', code: 'i2p', state: 'active')
end

i2p

puts "Was find or created option #{i2p.name}"
puts '----------------------------------'

def proxy
  @proxy ||= Option.where(name: 'Proxy').first_or_create(name: 'Proxy', code: 'proxy', state: 'active')
end

proxy

puts "Was find or created option #{proxy.name}"
