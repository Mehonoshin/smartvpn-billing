# frozen_string_literal: true

module Requests
  module ControllerMacros
    def login_admin
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        sign_in FactoryGirl.create(:admin)
      end
    end

    def login_user
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
    end
  end
end
