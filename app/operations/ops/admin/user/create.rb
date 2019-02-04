# frozen_string_literal: true

module Ops
  module Admin
    module User
      # This class create new user and send email with connection config, user password
      class Create < Base
        def call
          user.skip_confirmation_notification!
          return error_result unless user.save

          build_created_user!
          success_result
        end

        private

        def build_created_user!
          user.confirm
          CreateUserMailWorker.perform_async(user.id)
        end

        def user
          @user ||= ::User.new(params)
        end

        def error_result
          { success: false, user: user }
        end

        def success_result
          { success: true, user: user }
        end
      end
    end
  end
end
