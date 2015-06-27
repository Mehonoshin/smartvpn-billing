#!/usr/bin/env bats

@test "redis should be running" {
  [ "$(ps aux | grep redi[s])" ]
}

@test "redis should start on boot" {
  [ "$(chkconfig --list redis-persistant | grep 3:on)" ]
}

@test "redis should be listening on port 8000" {
  [ "$(netstat -plant | grep redis | grep 8000)" ]
}

@test "the config file should be in place" {
  [ -f /etc/redis/persistant.conf ]
}

@test "the redis user should be there" {
  [ "$(grep ^redis /etc/passwd)" ]
}

@test "the log directory should be there" {
  [ -d /var/log/redis ]
  [ -f /var/log/redis/persistant.log ]
}
