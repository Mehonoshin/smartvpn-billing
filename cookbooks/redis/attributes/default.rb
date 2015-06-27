#
# Cookbook Name:: redis
# Attributes:: default
#
# Copyright 2010, Atari, Inc
# Copyright 2012, CX, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# installation
default.redis.install_type   = "package"
default.redis.package_name   = "redis-server"
default.redis.source.sha     = "fdf61c693e5c4908b4bb44c428d4a2b7568f05566c144c58fdf19c5cb12a9caf"
default.redis.source.url     = "http://redis.googlecode.com/files"
default.redis.source.version = "2.6.14"
default.redis.src_dir    = "/usr/src/redis"
default.redis.dst_dir    = "/opt/redis"
default.redis.conf_dir   = "/etc/redis"
default.redis.init_style = "init"
default.redis.symlink_binaries = false
default.redis.ulimit = 10032

# service user & group
default.redis.user  = "redis"
default.redis.group = "redis"

###
## the following configuration settings may only work with a recent redis release
###
default.redis.config.configure_slowlog       = false
default.redis.config.slowlog_log_slower_than = 10000
default.redis.config.slowlog_max_len         = 1024

default.redis.config.configure_maxmemory_samples = false
default.redis.config.maxmemory_samples = 3

default.redis.config.configure_no_appendfsync_on_rewrite = false
default.redis.config.no_appendfsync_on_rewrite = false

default.redis.config.configure_list_max_ziplist = false
default.redis.config.list_max_ziplist_entries = 512
default.redis.config.list_max_ziplist_value   = 64

default.redis.config.configure_set_max_intset_entries = false
default.redis.config.set_max_intset_entries = 512

default.redis.config.configure_zset_max_ziplist_entries = false
default.redis.config.zset_max_ziplist_entries = 128

default.redis.config.configure_zset_max_ziplist_value = false
default.redis.config.zset_max_ziplist_value = 64

default.redis.config.configure_hash_max_ziplist_entries = false
default.redis.config.hash_max_ziplist_entries = 512

default.redis.config.configure_hash_max_ziplist_value = false
default.redis.config.hash_max_ziplist_value = 64

# replication
#default.redis.replication.enabled = false
#default.redis.replication.redis_replication_role = 'master' # or slave
#default.redis.replication.tunnel.enabled = false
#default.redis.replication.tunnel.accept_port = 46379
