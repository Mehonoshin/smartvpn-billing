set :stage, :staging
set :branch, 'master'
set :rails_env, :production

role :app, %w{deploy@stage.smartvpn.biz}
role :web, %w{deploy@stage.smartvpn.biz}
role :db,  %w{deploy@stage.smartvpn.biz}
