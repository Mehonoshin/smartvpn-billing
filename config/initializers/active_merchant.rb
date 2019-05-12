# frozen_string_literal: true

require 'active_merchant'

require 'offsite_payments/action_view_helper'
ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)

ActiveMerchant::Billing::Base.mode = :production
