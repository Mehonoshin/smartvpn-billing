# frozen_string_literal: true

class TransactionDecorator < Draper::Decorator
  delegate :id

  def amount
    amount_with_sign
  end

  def date
    h.human_date(model.created_at)
  end

  def description
    if payment?
      h.t('transaction.descriptions.payment', pay_system_name: model.object.pay_system.name)
    elsif withdrawal?
      h.t('transaction.descriptions.withdrawal', plan_name: model.object.plan.name)
    end
  end

  def user
    h.link_to transaction_user.email, h.admin_user_path(transaction_user.id)
  end

  private

  def amount_with_sign
    if payment?
      positive_amount
    elsif free_payment?
      free_amount
    elsif withdrawal?
      negative_amount
    end
  end

  def payment?
    model.object.is_a? Payment
  end

  def withdrawal?
    model.object.is_a? Withdrawal
  end

  def free_payment?
    withdrawal? && model.amount.zero?
  end

  def positive_amount
    h.content_tag :span, class: 'green bold' do
      "+#{amount_with_currency}"
    end
  end

  def negative_amount
    h.content_tag :span, class: 'red bold' do
      "-#{amount_with_currency}"
    end
  end

  def amount_with_currency
    (h.human_price model.amount).to_s
  end

  def free_amount
    h.content_tag :span, class: 'orange bold' do
      h.t('global.free')
    end
  end

  def transaction_user
    model.object.user
  end
end
