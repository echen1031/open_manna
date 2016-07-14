require 'rails_helper'

feature "User demos the sms sending" do
  before(:each) do
    user = create(:user)
    login_as user
  end

  scenario "sends a text message to user after clicking send" do
    create(:subscription)
    visit subscriptions_path
    binding.pry
  end
end
