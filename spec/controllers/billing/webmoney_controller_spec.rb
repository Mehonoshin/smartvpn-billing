require 'spec_helper'

describe Billing::WebmoneyController do
  render_views
  subject { response }

  it_behaves_like "validating pay_system state", :result, "LMI_PAYMENT_NO"
  it_behaves_like 'has success and fail responders'

  describe "POST #result" do
    describe "test request" do
      context "key param is not present" do
        let(:attrs) { Hash[] }

        before { post :result, attrs }

        it "renders YES text" do
          expect(subject.body).to include "YES"
        end
      end
    end

    describe "final request" do
      context "transaction_key_id is not defined" do
        let(:attrs) { Hash["LMI_HASH" => "test_hash"] }

        it "raises error" do
          expect {
            post :result, attrs
          }.to raise_error "Undefined transaction_item_id"
        end
      end

      context "notification signature is not valid" do
        let!(:payment) { create :payment }
        let(:attrs) { Hash["LMI_HASH" => "test_hash", "LMI_PAYMENT_NO" => payment.id, "LMI_PAYMENT_AMOUNT" => "123"] }

        it "raises error" do
          expect {
            post :result, attrs
          }.to raise_error "Invalid webmoney verification key"
        end
      end

      context "valid notification" do
        let!(:payment) { create :payment }
        let(:attrs) { Hash["LMI_MODE"=>"1", "LMI_PAYMENT_AMOUNT"=>"9.99", "LMI_PAYEE_PURSE"=>"Z164234536204", "LMI_PAYMENT_NO"=>"15", "LMI_PAYER_WM"=>"273350110703", "LMI_PAYER_PURSE"=>"Z133417776395", "LMI_SYS_INVS_NO"=>"407", "LMI_SYS_TRANS_NO"=>"601", "LMI_SYS_TRANS_DATE"=>"20131129 16:39:38", "LMI_HASH"=>"EDB5707A4FFC27225E59BFBB1CFB5CEA", "LMI_PAYMENT_DESC"=>"#15", "LMI_LANG"=>"ru-RU"] }

        before do
          Payment.stubs(:find).returns(payment)
          post :result, attrs
        end

        it "returns 200 state" do
          expect(subject.status).to eq 200
        end

        it "renders text" do
          expect(subject.body).to include "Done"
        end

        it "changes payment state to accepted" do
          expect(payment.reload.accepted?).to be true
        end
      end
    end
  end

end
