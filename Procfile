web: bundle exec rails s -p 3000 -b 0.0.0.0
worker: bundle exec sidekiq -q high -q default -q mailers
clockwork: clockwork config/clock.rb
