require 'rails_helper'

feature "User manages his or her subscription" do
  let(:user) { create(:user) }
  before(:each) do
    login_as user
  end

  scenario "creates subscription successfully" do
    visit new_user_subscription_path(user.id)
    fill_in 'Name', with: 'Morning Revival'
    fill_in 'Phone', with: '555-555-5555'
    select('Eastern', :from => 'Time zone')
    check 'subscription_send_monday'
    select('7 am', :from => 'Select Time')
    check 'subscription_send_monday'
    click_button 'Create'
    expect(Subscription.count).to eq 1
    subscription = Subscription.first
    expect(subscription.send_monday).to eq true
    expect(subscription.user_id).to eq user.id
    expect(subscription.name).to eq 'Morning Revival'
  end

  scenario "sees all subscriptions that belongs to him" do
    subscriptions = create_list(:subscription, 2)
    visit user_subscriptions_path(user.id)
    subscriptions.each do |s|
      expect(page).to have_content("#{s.name}")
    end
  end
end
