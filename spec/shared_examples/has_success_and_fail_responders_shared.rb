# frozen_string_literal: true

shared_examples 'has success and fail responders' do
  describe 'GET #success' do
    before { get :success }

    it 'redirects to root billing path' do
      expect(subject).to redirect_to billing_root_path
    end
  end

  describe 'GET #fail' do
    before { get :fail }

    it 'redirects to root billing path' do
      expect(subject).to redirect_to billing_root_path
    end
  end
end
