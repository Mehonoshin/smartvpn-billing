#!/usr/bin/env bats

@test "It should create the log directory" {
   [ -d /var/log/redis ]
}

