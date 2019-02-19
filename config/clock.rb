# frozen_string_literal: true

require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'

# TODO
# Instead of loading whole application, we can use this approach of sending tasks to Sidekiq
# https://github.com/mperham/sidekiq/wiki/FAQ#how-do-i-push-a-job-to-sidekiq-without-ruby

module Clockwork
  every(1.hour, 'Withdrawals') { WithdrawalsWorker.perform_async }
  every(1.hour, 'UpdateCourses') { UpdateCoursesWorker.perform_async }
  every(1.hour, 'RefreshProxyList') { RefreshProxyListWorker.perform_async }
end
