require 'rails_helper'

describe DailySMSWorker do
  let(:sms_client) { double }
  let(:response) { double }
  let(:success) { '0' }
  let(:status_code) { double }
  let(:status_text) { double }
  let(:msg_id) { double }
  let(:to) { double }

  describe '#perform' do
    it 'performs' do
      pending
      subscription = create(:subscription)
      verse = create(:verse)
      phone_number = subscription.phone_number
      verse_text = "John 1:1 - " + verse.text + " - OpenManna.com"
      expect(SMSClient).to receive(:new).and_return(sms_client)
      expect(sms_client).to receive(:send_message).with(to: phone_number, text: verse_text).and_return(response)
      expect(response).to receive(:[]).with('status').and_return(success)
      expect(SubscriptionVerse).to receive(:create).with(subscription_id: subscription.id, verse_id: verse.id)
      expect(SmsClientLogger).to receive(:create).with(status_code: status_code, status_text: status_text, message_id: msg_id, to: to)

      DailySMSWorker.new.perform(subscription.id, verse.id)
    end
  end
end
