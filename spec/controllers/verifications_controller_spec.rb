require 'rails_helper'

describe VerificationsController, type: :controller do
  let(:user) { create(:user) }
  before do
    sign_in(user)
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
        expect(SMSClient).to receive(:new).and_return(nexmo_client)
        expect(nexmo_client).to receive(:send_welcome_message).with(to: sub.phone_number)
        put :update, params: {id: request_id, code: verification_code, sub_id: sub.id}
        expect(Subscription.first.active).to eq true
      end
    end
  end
end
