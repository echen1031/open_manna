require 'rails_helper'

feature "User manages his or her subscription" do
  before(:each) do
    user = create(:user)
    login_as user
  end

  scenario "creates subscription successfully" do
    visit new_subscription_path
    expect(Subscription.count).to eq 1
  end
end
