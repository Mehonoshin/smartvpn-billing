# frozen_string_literal: true

require 'active_merchant'
require 'offsite_payments/action_view_helper'

# https://github.com/activemerchant/active_merchant/issues/1397
ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)

ActiveMerchant::Billing::Base.mode = :production
