require 'rails_helper'

feature "User manages his or her subscription" do
  let(:user) { create(:user) }
  before(:each) do
    login_as user
  end

  scenario "creates subscription successfully" do
    visit subscriptions_path
    click_link 'New Subscription'
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
    subscriptions = create_list(:subscription, 2, user_id: user.id)
    visit subscriptions_path
    subscriptions.each do |s|
      expect(page).to have_content("#{s.name}")
    end
  end

  scenario "updates his subscription successfully" do
    subscription = create(:subscription)
    visit subscriptions_path
    click_link "Edit"
    fill_in "Name", with: "Test"
    select('Eastern', :from => 'Time zone')
    click_button "Update Subscription"
    subscription.reload
    expect(subscription.name).to eq "Test"
  end

  scenario "deletes his subscription successfully" do
    create(:subscription)
    visit subscriptions_path
    click_link "Delete"
    expect(Subscription.count).to eq 0
  end
end
