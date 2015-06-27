shared_examples "validating pay_system state" do |action, payment_id_key|
  describe "pay_system state validation" do
    context 'if pay system is disabled' do
      let(:pay_system) { create(:pay_system) }
      let(:payment) { create(:payment, pay_system: pay_system) }

      it 'raises error' do
        expect {
          post action, { payment_id_key => payment.id }
        }.to raise_error BillingException
      end
    end
  end
end
