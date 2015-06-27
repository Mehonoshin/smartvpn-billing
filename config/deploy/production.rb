set :stage, :production
set :branch, 'master'
set :rails_env, :production

role :app, %w{deploy@billing.smartvpn.biz}
role :web, %w{deploy@billing.smartvpn.biz}
role :db,  %w{deploy@billing.smartvpn.biz}
