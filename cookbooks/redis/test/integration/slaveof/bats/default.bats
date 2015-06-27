#!/usr/bin/env bats

@test "redis should be running" {
  [ "$(ps aux | grep redi[s])" ]
}

@test "It should add slaveof to server.conf" {
  grep 'slaveof 198.18.0.1 3000' /etc/redis/server.conf              
}
