# frozen_string_literal: true

module Ops
  module Admin
    module User
      class Create
        attr_reader :params

        def initialize(params:)
          @params = params
        end

        def call
          user.skip_confirmation_notification!
          return error_create_user unless user.save

          build_created_user!
          success_result
        end

        private

        def build_created_user!
          user.confirm
          CreateUserMailWorker.perform_async(user_id: user.id, crypted_password: Base64.encode64(params[:password]))
        end

        def user
          @user ||= ::User.new(params)
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
