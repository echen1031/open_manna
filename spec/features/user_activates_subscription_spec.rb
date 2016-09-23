require 'rails_helper'

feature "User activates a subscription having already being an user" do
  let(:user) { create(:user) }
  before(:each) do
    login_as(user, :scope => :user)
    verse = create(:verse)
    subscription = create(:subscription, user_id: user.id)
    create(:subscription_verse, user_id: user.id, verse_id: verse.id, subscription_id: subscription.id)
  end

  scenario "activates his subscription successfully" do
    sub = create(:inactive_subscription, user_id: user.id)
    send_result = double("send_result")
    request_id = "12345"
    code = "5555"
    allow(VerificationRequestSender).to receive(:new).with(sub.phone_number).and_return(send_result)
    allow(send_result).to receive(:send_successful_request?).and_return true
    allow(send_result).to receive(:request_id).and_return request_id

    visit subscriptions_path
    click_link "Verify"

    expect(send_result).to have_received(:send_successful_request?)
    expect(send_result).to have_received(:request_id)
    expect(page).to have_content("Verification Code")

    check_result = double("check_result")
    allow(VerificationRequestChecker).to receive(:new).with(request_id, code).and_return(check_result)
    allow(check_result).to receive(:phone_number_confirmed?).and_return true
    fill_in "Code", with: code
    click_button "Verify"

    sub.reload
    expect(check_result).to have_received(:phone_number_confirmed?)
    expect(sub.active).to eq true
  end
end
