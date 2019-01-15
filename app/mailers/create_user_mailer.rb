# frozen_string_literal: true

class CreateUserMailer < ActionMailer::Base
  default from: 'admin@smartvpn.biz'

  def notify(user:, crypted_password:)
    @user = user
    @password = Base64.decode64(crypted_password)
    attachments["#{server.hostname}.ovpn"] = server_config
    mail(to: @user.email, subject: t('mailers.invite_user_mailer.subject'))
  end

  private

  def server_config
    @server_config ||= ServerConfigBuilder.new(server: server).to_text
  end

  def server
    @server ||= @user.plan.servers.last
  end
end
