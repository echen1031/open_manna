require 'rails_helper'

feature "User manages his or her subscription" do
  before(:each) do
    user = create(:user)
    login_as user
  end

  scenario "creates subscription successfully" do
    user = User.first
    visit new_subscription_path
    fill_in 'Phone', with: '555-555-5555'
    select('Eastern', :from => 'Time zone')
    check 'subscription_send_day_1'
    select('7 am', :from => 'Select Time')
    check 'subscription_send_day_1'
    click_button 'Create'
    expect(Subscription.count).to eq 1
    subscription = Subscription.first
    expect(subscription.send_day_1).to eq true
    expect(subscription.user_id).to eq user.id
  end
end
