# frozen_string_literal: true

class UserConnectionConfigMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM']

  def notify(user:)
    @user = user
    attachments["#{server.hostname}.ovpn"] = server_config
    mail(to: @user.email, subject: t('mailers.user_connection_config_mailer.subject'))
  end

  private

  def server_config
    @server_config ||= ServerConfigBuilder.new(server: server).to_text
  end

  def server
    @server ||= @user.plan.servers.last
  end
end
