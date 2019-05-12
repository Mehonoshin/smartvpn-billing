# frozen_string_literal: true

module Requests
  module ControllerMacros
    def login_admin
      before do
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        sign_in FactoryBot.create(:admin)
      end
    end

    def login_user
      before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = FactoryBot.create(:user)
        sign_in @user
      end
    end
  end
end
