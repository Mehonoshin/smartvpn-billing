ruby_version = `cat ~/.ruby-version`.tr("\n","")
job_type :rbenv_rake, "cd :path && :environment_variable=:environment RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=#{ruby_version} /usr/local/rbenv/bin/rbenv exec bundle exec rake :task --silent :output"
job_type :rbenv_exec, "cd :path && :environment_variable=:environment RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=#{ruby_version} /usr/local/rbenv/bin/rbenv exec :task"

every :hour do
  rbenv_rake "smartvpn:withdrawals:run"
end

every :hour do
  rbenv_rake "smartvpn:courses:update"
end

every :hour do
  rbenv_rake "smartvpn:proxy:update"
end

if `hostname`.strip == 'billing.smartvpn.biz'
  every 1.day do
    rbenv_exec  'backup perform --trigger=daily --config-file=./config/backup/config.rb'
  end
end
