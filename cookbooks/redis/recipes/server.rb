include_recipe "redis::install"

redis_instance "server" do
  conf_dir      node.redis.conf_dir
  init_style    node.redis.init_style

  # user service & group
  user          node.redis.user
  group         node.redis.group

  node.redis.config.each do |attribute, value|
    send(attribute, value)
  end
end
