require 'rails_helper'

feature "User receives verse from openmanna" do
  let(:sms_client) { double }
  let(:response) { double }
  let(:success) { '0' }

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
      expect(response).to receive(:[]).with('status').and_return(success)
      SmsScheduler.set_daily_sms_job
      expect(SubscriptionVerse.count).to eq 1

    end
  end
end
