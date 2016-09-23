require 'rails_helper'

describe DailySMSWorker do
  let(:sms_client) { double }
  let(:response) { double }
  let(:nexmo_response) { double }
  let(:status_code) { "0" }
  let(:status_text) { "success" }
  let(:msg_id) { "12345" }
  let(:to) { "+15555555555" }

  describe '#perform' do
    it 'performs' do
      user = create(:user)
      subscription = create(:subscription, user_id: user.id)
      verse = create(:verse)
      phone_number = subscription.phone_number
      verse_text = "John 1:1 - " + verse.text + " - OpenManna.com"
      expect(SMSClient).to receive(:new).and_return(sms_client)
      expect(sms_client).to receive(:send_message).with(to: phone_number, text: verse_text).and_return(response)
      expect(NexmoResponseManager).to receive(:new).with(response).and_return(nexmo_response)
      expect(nexmo_response).to receive(:status_code).and_return(status_code)
      expect(nexmo_response).to receive(:status_text).and_return(status_text)
      expect(nexmo_response).to receive(:message_id).and_return(msg_id)
      expect(nexmo_response).to receive(:to).and_return(to)
      expect(SMSClientLogger).to receive(:create).with(status_code: status_code, status_text: status_text, message_id: msg_id, to: to)
      expect(nexmo_response).to receive(:successful).and_return(true)
      expect(SubscriptionVerse).to receive(:create).with(subscription_id: subscription.id, verse_id: verse.id, user_id: user.id)

      DailySMSWorker.new.perform(subscription.id, verse.id)
    end
  end
end
