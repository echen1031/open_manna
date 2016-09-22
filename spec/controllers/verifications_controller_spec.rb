require 'rails_helper'

describe VerificationsController, type: :controller do
  let(:user) { create(:user) }
  before do
    sign_in :user, user
  end
  let(:request_id) { double }
  let(:result) { double }
  let(:verification_code) { double }
  let(:sub) { create(:inactive_subscription) }
  let(:nexmo_client) { double }

  context "User verifies phone number after very first subscription" do
    describe "#update" do
      it "sends a welcome text" do
        expect(VerificationRequestChecker).to receive(:new).and_return(result)
        expect(result).to receive(:phone_number_confirmed?).and_return(true)
        put :update, {:id => request_id, :code => verification_code, :sub_id => sub.id}
        expect(Subscription.first.active).to eq true
        expect(SMSClient).to receive(:new).and_return(nexmo_client)
      end
    end
  end
end
