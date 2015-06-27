#!/usr/bin/env bats

@test "backported package is installed" {
    dpkg -l tmux | awk '$1=="ii" && $3 ~ /~bpo/ { ok=1 } END { exit !ok }'
}
