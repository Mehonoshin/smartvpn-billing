# frozen_string_literal: true

require 'spec_helper'

describe Billing::PromotionsController do
  subject { response }

  let(:promo_code) { 'promo' }
  let(:settings_path) { edit_user_registration_path }

  describe 'POST #create' do
    context 'when not authorized' do
      it 'does not respond' do
        post :create, params: { promo: { code: promo_code } }
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context 'logged in' do
      login_user

      context 'promo with such code does not exist' do
        before do
          post :create, params: { promotion: { promo_code: promo_code } }
        end

        it 'redirects to settings page' do
          expect(subject).to redirect_to settings_path
        end

        it 'renders info, that promo not found' do
          expect(flash[:alert]).to include I18n.t('billing.promotions.notices.no_promos_found')
        end
      end

      context 'promotion already exists' do
        let!(:promo) { create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now, promo_code: promo_code) }
        let!(:promotion) { create(:promotion, user: User.last, promo: promo) }

        before do
          post :create, params: { promotion: { promo_code: promo_code } }
        end

        it 'redirects to settings page' do
          expect(subject).to redirect_to settings_path
        end

        it 'renders info, that promo already activated' do
          expect(flash[:alert]).to include I18n.t('billing.promotions.notices.promotion_already_activated')
        end
      end

      context 'promo exists, promotion not' do
        let!(:promo) { create(:active_promo, date_from: 1.week.ago, date_to: 1.week.from_now, promo_code: promo_code) }

        before { post :create, params: { promotion: { promo_code: promo_code } } }

        it 'redirects to settings page' do
          expect(subject).to redirect_to settings_path
        end

        it 'renders info, that promo activated' do
          expect(flash[:notice]).to include I18n.t('billing.promotions.notices.promotion_activated')
        end

        it 'creates promotion' do
          expect(Promotion.count).to eq 1
        end
      end
    end
  end
end
