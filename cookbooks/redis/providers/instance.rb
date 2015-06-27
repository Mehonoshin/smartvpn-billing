def load_current_resource
  # Because these attributes are loaded lazily
  # we have to call each one explicitly
  new_resource.pidfile      new_resource.pidfile || "/var/run/redis/#{new_resource.name}.pid"
  new_resource.logfile      new_resource.logfile || "/var/log/redis/#{new_resource.name}.log"
  new_resource.dbfilename   new_resource.dbfilename || "#{new_resource.name}.rdb"
  new_resource.user         new_resource.user  || node.redis.user
  new_resource.group        new_resource.group || node.redis.group

  new_resource.slaveof_ip   new_resource.slaveof_ip
  new_resource.slaveof_port new_resource.slaveof_port || node.redis.config.port

  if new_resource.slaveof_ip || new_resource.slaveof
    new_resource.slaveof      new_resource.slaveof || "#{new_resource.slaveof_ip} #{new_resource.slaveof_port}"
  end
    
  new_resource.configure_no_appendfsync_on_rewrite
  new_resource.configure_slowlog
  new_resource.configure_list_max_ziplist
  new_resource.configure_maxmemory_samples
  new_resource.configure_set_max_intset_entries
  new_resource.configure_zset_max_ziplist_entries
  new_resource.configure_zset_max_ziplist_value
  new_resource.configure_hash_max_ziplist_entries
  new_resource.configure_hash_max_ziplist_value
  new_resource.conf_dir

  new_resource.state # Load attributes

  @run_context.include_recipe "runit" if new_resource.init_style == "runit"
end

action :create do
  create_user_and_group
  create_directories
  if node.platform_family == "rhel" && node.redis.install_type == "package"
    # For RHEL package installs, use the RPM's init script and set REDIS_USER
    create_sysconfig_file  
  else
    create_service_script
  end
  create_config
  enable_service
  new_resource.updated_by_last_action(true)
end


action :destroy do
  disable_service
  new_resource.updated_by_last_action(true)
end

private

def create_user_and_group
  group new_resource.group

  user new_resource.user do
    gid new_resource.group
  end
end

def create_directories
  directory "#{::File.dirname(new_resource.logfile)} (#{new_resource.name})" do
    path ::File.dirname(new_resource.logfile)
    owner new_resource.user
    group new_resource.group
    mode 00755
    only_if { new_resource.logfile.downcase != "stdout" }
  end

  directory new_resource.conf_dir do
    owner "root"
    group "root"
    mode 00755
  end

  directory new_resource.dir do
    owner new_resource.user
    group new_resource.group
    mode 00755
  end

  directory ::File.dirname(new_resource.pidfile) do
    owner new_resource.user
    group new_resource.group
    mode 00755
  end
end

def create_config
  redis_service_name = redis_service
  template "#{new_resource.conf_dir}/#{new_resource.name}.conf" do
    source "redis.conf.erb"
    owner "root"
    group "root"
    mode 00644
    variables :config => new_resource.state
    case new_resource.init_style
    when "init"
      notifies :restart, "service[#{redis_service_name}]"
    when "runit"
      notifies :restart, "runit_service[#{redis_service_name}]"
    end
  end
end

# For RHEL-based installs, to set $REDIS_USER
def create_sysconfig_file
  file "/etc/sysconfig/redis" do
    owner "root"
    group "root"
    mode "0755"
    content "REDIS_USER=#{new_resource.user}\n"
  end
end

def set_dst_dir
  case node.platform_family
  when "rhel", "fedora"
    node.set[:redis][:dst_dir] = "/usr/sbin/"
  when "debian"
    node.set[:redis][:dst_dir] = "/usr/bin/"
  end
end

def create_service_script
  set_dst_dir if node.redis.install_type == "package"
  case new_resource.init_style
  when "init"
    template "/etc/init.d/redis-#{new_resource.name}" do
      source "redis_init.erb"
      owner "root"
      group "root"
      mode 00755
      variables new_resource.to_hash
    end
  when "runit"
    runit_service "redis" do
      options({
        :name     => new_resource.name,
        :dst_dir  => new_resource.dst_dir,
        :conf_dir => new_resource.conf_dir,
        :user     => new_resource.user
      })
    end
  end
end

def enable_service
  service redis_service do
    action [ :enable, :start ]
  end
end

def disable_service
  service redis_service do
    action [ :disable, :stop ]
  end
end

def redis_service
  if node.platform_family == "rhel" && node.redis.install_type == "package"
    "redis"
  else
    "redis-#{new_resource.name}"
  end
end
