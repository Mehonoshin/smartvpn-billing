# To prevent popping up email notifications from seeds we off
ActionMailer::Base.perform_deliveries = false

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
