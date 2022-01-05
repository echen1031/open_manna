require 'rails_helper'

describe DailySMSWorker do
  let(:sms_client) { double }
  let(:response) { double }
  let(:vonage_response) { double }
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
      verse_text = "John 1:1 - " + verse.text + " - OpenManna.com. Reply STOP to stop subscription"
      expect(SMSClient).to receive(:new).and_return(sms_client)
      expect(sms_client).to receive(:send_message).with(to: phone_number, text: verse_text).and_return(response)

      DailySMSWorker.new.perform(subscription.id, verse.id)
    end
  end
end
