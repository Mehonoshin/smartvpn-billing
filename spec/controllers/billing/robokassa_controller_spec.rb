require 'spec_helper'

describe Billing::RobokassaController do
  render_views
  subject { response }

  it_behaves_like "validating pay_system state", :result, "InvId"
  it_behaves_like 'has success and fail responders'

  describe "POST #result" do
    context "notification signature is not valid" do
      let(:attrs) { Hash[] }

      it "raises error" do
        expect {
          post :result, attrs
        }.to raise_error "Invalid robokassa notification"
      end
    end

    context "valid notification" do
      let!(:payment) { create :payment }
      let(:attrs) { Hash["OutSum"=>"9.99", "InvId"=>"10", "SignatureValue"=>"D25F8F107E3482EF3CCAFC620CC8BA3E"] }

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
