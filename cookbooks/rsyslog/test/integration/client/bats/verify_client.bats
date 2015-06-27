@test "the config points to the remote server" {
  grep "@10.0.0.50:514" /etc/rsyslog.d/49-remote.conf
}
