# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: 'admin@smartvpn.biz'

  def funds_recieved(user, amount)
    @user = user
    @amount = amount
    mail(to: user.email, subject: I18n.t('user_mailer.funds_recieved.subject'))
  end

  def balance_withdrawal(user, amount)
    @user = user
    @amount = amount
    mail(to: user.email, subject: I18n.t('user_mailer.balance_withdrawal.subject'))
  end

  def could_not_withdraw_funds(user, amount)
    @user = user
    @amount = amount
    mail(to: user.email, subject: I18n.t('user_mailer.could_not_withdraw_funds.subject'))
  end

  def test_period_enabled(user)
    @user = user
    mail(to: user.email, subject: I18n.t('user_mailer.test_period_enabled.subject'))
  end

  # Sent on 3rd unsuccessful withdrawal
  # if user doesn't have previous successful withdrawals
  def unpaid_user_notification(user)
    mail(to: user.email, subject: I18n.t('user_mailer.unpaid_user_notification.subject'))
  end
end
