set :application, 'smartvpn'
set :repo_url, ''

set :deploy_to, '/home/deploy'
set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true
set :rails_env, :production

set :linked_dirs, %w{log public/uploads}

set :keep_releases, 5

set :rbenv_type, :system
# NOTICE:
# temporary disable ruby version auto select
# move back, when 2.1.4 ruby will build successfully
# set :rbenv_ruby, `cat .ruby-version`.tr("\n","")
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

namespace :deploy do
  desc 'Start application server'
  task :start do
    on roles(:app) do
      execute "sv start ~/sv/unicorn"
      execute "sv start ~/sv/sidekiq"
    end
  end

  desc 'Stop application server'
  task :stop do
    on roles(:app) do
      execute "sv stop ~/sv/unicorn"
      execute "sv stop ~/sv/sidekiq"
    end
  end

  desc 'Restart application server'
  task :restart do
    on roles(:app) do
      execute "sv restart ~/sv/unicorn"
      execute "sv restart ~/sv/sidekiq"
    end
  end

  task :notify_rollbar do
    on roles(:app) do |h|
      revision = `git log -n 1 --pretty=format:"%H"`
      local_user = `whoami`
      rollbar_token = ''
      rails_env = fetch(:rails_env, 'production')
      execute "curl https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user} >/dev/null 2>&1", :once => true
    end
  end

  task :seed_initial_data do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'smartvpn:initial_data:seed'
        end
      end
    end
  end

  after :published, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after :deploy, 'deploy:notify_rollbar'
  after :deploy, 'deploy:seed_initial_data'
end
