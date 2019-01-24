# frozen_string_literal: true

class Admin
  class ProfilesController < Admin::BaseController
    before_action :find_admin, only: %i[edit update]

    def edit; end

    def update
      if @admin.update_with_password(admin_params)
        bypass_sign_in(@admin)
        redirect_to edit_admin_profile_path, notice: t('admin.profile.notices.updated')
      else
        render :edit
      end
    end

    private

    def find_admin
      @admin = current_admin
    end

    def admin_params
      params.require(:admin).permit(:password, :password_confirmation, :current_password)
    end
  end
end
