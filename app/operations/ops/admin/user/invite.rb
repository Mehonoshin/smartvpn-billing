# frozen_string_literal: true

module Ops
  module Admin
    module User
      class Invite
        attr_reader :params

        def initialize(params:)
          @params = params
        end

        def call
          user.skip_confirmation_notification!
          return error_create_user unless user.save

          build_invited_user!
          success_result
        end

        private

        def build_invited_user!
          user.confirm
          user.send_reset_password_instructions
          InviteUserMailWorker.perform_async(user.id)
        end

        def user
          @user ||= ::User.new(params.merge(password: generate_password))
        end

        def generate_password
          SecureRandom.alphanumeric
        end

        def error_create_user
          { success: false, user: user }
        end

        def success_result
          { success: true, user: user }
        end
      end
    end
  end
end
