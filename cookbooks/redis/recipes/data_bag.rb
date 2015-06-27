include_recipe "redis::install"

bag = node.redis.data_bag_name

node.redis.instances.each do |instance|
  instance_data = data_bag_item( bag, instance )
  name = instance_data["name"] || instance
    
  redis_instance name do
    instance_data.each do |attribute,value|
      send(attribute, value) unless attribute == "id"
    end
  end
end

node.redis.sentinels.each do |sentinel|
  sentinel_data = data_bag_item( bag, sentinel )

  redis_sentinel sentinel do
    sentinel_data.each do |attribute,value|
      send(attribute, value) unless attribute == "id"
    end
  end
end
