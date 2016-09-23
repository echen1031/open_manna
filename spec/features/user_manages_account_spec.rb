require 'rails_helper'

feature "user manages account" do
  let!(:user) { create(:user) }
  before(:each) do
    login_as(user, :scope => :user)
  end

  scenario "updates user account successfully" do
    visit root_path
    click_link "Profile"
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    user.reload
    expect(user.email).to eq 'user@example.com'
  end

  scenario "Deletes account altogether" do
    visit root_path
    click_link "Profile"
    click_link "Cancel my account"
    expect(User.count).to eq 0
  end

  scenario "Deletes account and subsequent subscription verses" do
    sub = create(:subscription, user_id: user.id, active: false)
    create(:subscription_verse, subscription_id: sub.id, user_id: user.id)
    visit root_path
    click_link "Profile"
    click_link "Cancel my account"
    expect(User.count).to eq 0
    expect(Subscription.count).to eq 0
    expect(SubscriptionVerse.count).to eq 0
  end
end
