require 'spec_helper'

describe 'user profile' do
  let!(:user) { create(:user) }
  let!(:disconnect) { create(:disconnect, user: user) }

  context 'user disconnected' do
    it 'displays user connection status' do
      sign_in_admin
      visit admin_user_path(user)

      expect(page).to have_content I18n.t('admin.users.current_connection')

      expect(
        find('.user_current_connection')
      ).to have_content I18n.t('admin.users.not_connected')
    end
  end

end
