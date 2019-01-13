# frozen_string_literal: true

class InviteUserMailer < ActionMailer::Base
  default from: 'admin@smartvpn.biz'

  def notify(user)
    @user = user
    server = user.plan.servers.last
    attachments["#{server.hostname}.ovpn"] = File.read(generate_config(server).path)
    mail(to: @user.email, subject: t('mailers.invite_user_mailer.subject'))
  end

  private

  def generate_config(server)
    binding.pry
    ServerConfigBuilder.new(server).generate_config
  end
end
