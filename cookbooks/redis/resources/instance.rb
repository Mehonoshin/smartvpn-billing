actions :create,  :destroy

attribute :name,  :kind_of => String, :name_attribute => true

attribute :user,  :kind_of => String, :default => "redis"
attribute :group, :kind_of => String, :default => "redis"

attribute :init_style,     :kind_of => String, :default => "init"

# configuration
attribute :appendonly,     :kind_of => [TrueClass, FalseClass], :default => false
attribute :appendfsync,    :kind_of => String, :default => "everysec"
attribute :daemonize,      :kind_of => [TrueClass, FalseClass], :default => true
attribute :databases,      :kind_of => Fixnum, :default => 16
attribute :dbfilename,     :kind_of => String#, :default => "#{name}.rdb"
attribute :dir,            :kind_of => String, :default => "/var/lib/redis"
attribute :conf_dir,       :kind_of => String, :default => "/etc/redis"
attribute :bind,           :kind_of => String, :default => "127.0.0.1"
attribute :port,           :kind_of => Fixnum, :default => 6379
attribute :logfile,        :kind_of => String#, :default => "/var/log/redis/#{name}.log"
attribute :loglevel,       :kind_of => String, :default => "warning"
attribute :pidfile,        :kind_of => String#, :default => "/var/run/redis/#{name}.pid"
attribute :rdbcompression, :kind_of => [TrueClass, FalseClass], :default => true
attribute :timeout,        :kind_of => Fixnum, :default => 300
attribute :save,           :kind_of => Array,  :default => ['900 1', '300 10', '60 10000']
attribute :activerehashing,:kind_of => [TrueClass, FalseClass], :default => true
attribute :slaveof,        :kind_of => String, :default => nil
attribute :slaveof_ip,     :kind_of => String, :default => nil
attribute :slaveof_port,   :kind_of => Integer, :default => nil

###
## the following configuration settings may only work with a recent redis release
###
attribute :configure_slowlog,                   :kind_of => [TrueClass, FalseClass], :default => false
attribute :slowlog_log_slower_than,             :kind_of => Fixnum,                  :default => 10000
attribute :slowlog_max_len,                     :kind_of => Fixnum,                  :default => 1024

attribute :configure_maxmemory_samples,         :kind_of => [TrueClass, FalseClass], :default => false
attribute :maxmemory_samples,                   :kind_of => Fixnum,                  :default => 3

attribute :configure_no_appendfsync_on_rewrite, :kind_of => [TrueClass, FalseClass], :default => false
attribute :no_appendfsync_on_rewrite,           :kind_of => [TrueClass, FalseClass], :default => false

attribute :configure_list_max_ziplist,          :kind_of => [TrueClass, FalseClass], :default => false
attribute :list_max_ziplist_entries,            :kind_of => Fixnum,                  :default => 512
attribute :list_max_ziplist_value,              :kind_of => Fixnum,                  :default => 64

attribute :configure_set_max_intset_entries,    :kind_of => [TrueClass, FalseClass], :default => false
attribute :set_max_intset_entries,              :kind_of => Fixnum,                  :default => 512

attribute :configure_zset_max_ziplist_entries,  :kind_of => [TrueClass, FalseClass], :default => false
attribute :zset_max_ziplist_entries,            :kind_of => Fixnum,                  :default => 128

attribute :configure_zset_max_ziplist_value,    :kind_of => [TrueClass, FalseClass], :default => false
attribute :zset_max_ziplist_value,              :kind_of => Fixnum,                  :default => 64

attribute :configure_hash_max_ziplist_entries,  :kind_of => [TrueClass, FalseClass], :default => false
attribute :hash_max_ziplist_entries,            :kind_of => Fixnum,                  :default => 512

attribute :configure_hash_max_ziplist_value,    :kind_of => [TrueClass, FalseClass], :default => false
attribute :hash_max_ziplist_value,              :kind_of => Fixnum,                  :default => 64

def initialize(*args)
    super
    @action = :create
end
state_attrs(
 :appendonly,
 :appendfsync,
 :daemonize,
 :databases,
 :dbfilename,
 :dir,
 :bind,
 :port,
 :logfile,
 :loglevel,
 :pidfile,
 :rdbcompression,
 :timeout,
 :save,
 :activerehashing,
 :slaveof,
            
 :slowlog_log_slower_than,
 :slowlog_max_len,

 :maxmemory_samples,

 :no_appendfsync_on_rewrite,

 :list_max_ziplist_entries,
 :list_max_ziplist_value,

 :zset_max_ziplist_entries,
 :zset_max_ziplist_value,

 :hash_max_ziplist_entries,
 :hash_max_ziplist_value,

 :set_max_intset_entries
)
