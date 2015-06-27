# https://github.com/meskyanichi/backup

Backup::Model.new(:daily, 'Backup DB daily and keep them 15 days') do

  split_into_chunks_of 250

  database PostgreSQL do |db|
    require 'yaml'
    env = ENV.fetch('RAILS_ENV'){'production'}

    db_config_file = FS_ROOT + '/config/database.yml'
    parsed_file = ERB.new(File.read(db_config_file)).result
    db_config = YAML.load(parsed_file)[env]

    db.name               = db_config['database']
    db.username           = db_config['username']
    db.host               = db_config['host']
    db.additional_options = ["-E=utf8"]
  end

  store_with S3 do |s3|
    s3.access_key_id     = ''
    s3.secret_access_key = ''

    s3.region             = ''
    s3.bucket             = ''
    s3.path               = ''
  end

  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = ''
    mail.to                   = ''
    mail.address              = ''
    mail.port                 = 587
    mail.domain               = ''
    mail.user_name            = ''
    mail.password             = ''
    mail.authentication       = ''
    mail.encryption           = :starttls
    mail.send_log_on = [:success, :warning, :failure] # attach to all notifications
  end

  compress_with Gzip
end
