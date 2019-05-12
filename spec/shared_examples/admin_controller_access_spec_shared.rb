# frozen_string_literal: true

shared_examples 'requires admin access' do |method, action, params|
  context 'is admin' do
    login_user

    it 'does not allow to be accessed by user' do
      send(method, action, params: params)
      expect(response).to redirect_to new_admin_session_path
    end
  end
end
