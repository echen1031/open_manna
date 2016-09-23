require 'rails_helper'

feature "User receives verse from openmanna" do
  let(:sms_client) { double }
  let(:response) { double }
  let(:nexmo_response) { double }
  let(:status_code) { "0" }

  scenario "successfully" do
    pending
    Timecop.travel("2016-07-10") #Sunday
    sub = create(:subscription, send_sunday: true)
    verse = create(:verse)
    phone_number = sub.phone_number
    verse_text = "John 1:1 - " + verse.text + " - OpenManna.com"
    Sidekiq::Testing.inline! do
      expect(SMSClient).to receive(:new).and_return(sms_client)
      expect(sms_client).to receive(:send_message).with(to: phone_number, text: verse_text).and_return(response)
      expect(nexmo_response).to receive(:status_code).and_return(status_code)
      expect(nexmo_response).to receive(:status_text).and_return("text")
      expect(nexmo_response).to receive(:message_id).and_return("12345")
      expect(nexmo_response).to receive(:message_id).and_return("12345")
      expect(NexmoResponseManager).to receive(:new).and_return(nexmo_response)
      SMSScheduler.set_daily_sms_job
      expect(SubscriptionVerse.count).to eq 1

    end
  end
end
