require 'rails_helper'

feature "User manages his or her subscription" do
  let(:user) { create(:user) }
  before(:each) do
    login_as(user, :scope => :user)
  end

  context "Creating subscription" do
    context "Successful Creation" do
      scenario "creates monday subscription" do
        creates_a_monday_subscription
        expect(Subscription.first.send_monday).to eq true
      end

      scenario "creates tuesday subscription" do
        creates_a_tuesday_subscription
        expect(Subscription.first.send_tuesday).to eq true
      end

      scenario "creates wednesday subscription" do
        creates_a_wednesday_subscription
        expect(Subscription.first.send_wednesday).to eq true
      end

      scenario "creates thursday subscription" do
        creates_a_thursday_subscription
        expect(Subscription.first.send_thursday).to eq true
      end

      scenario "creates friday subscription" do
        creates_a_friday_subscription
        expect(Subscription.first.send_friday).to eq true
      end

      scenario "creates saturday subscription" do
        creates_a_saturday_subscription
        expect(Subscription.first.send_saturday).to eq true
      end

      scenario "creates sunday subscription" do
        creates_a_sunday_subscription
        expect(Subscription.first.send_sunday).to eq true
      end

      scenario "creates a second subscription" do
        create(:subscription, user_id: user.id)
        visit subscriptions_path
        click_link 'New Subscription'
        fill_in 'Name', with: 'Morning Revival'
        fill_in 'Phone number', with: '555-555-5555'
        select('Eastern', :from => 'subscription[time_zone]')
        select('7 am', :from => 'Select Time')
        check 'subscription_send_monday'
        click_button 'Create'
        expect(page).to have_content "Subscription created successfully."
        expect(Subscription.count).to eq 2
      end
    end

    context "Unsuccessful Creation" do
      scenario "User hits subscriptino limit" do
        create_list(:subscription, 2, user_id: user.id)
        visit subscriptions_path
        click_link 'New Subscription'
        fill_in 'Name', with: 'Morning Revival'
        fill_in 'Phone number', with: '555-555-5555'
        select('Eastern', :from => 'subscription[time_zone]')
        select('7 am', :from => 'Select Time')
        check 'subscription_send_monday'
        click_button 'Create'
        expect(page).to have_content("Sorry, only two subscriptions per user are allowed at this time.")
        expect(Subscription.count).to eq 2
      end
    end
  end

  scenario "sees all subscriptions that belongs to him" do
    subscriptions = create_list(:subscription, 2, user_id: user.id)
    visit subscriptions_path
    subscriptions.each do |s|
      expect(page).to have_content("#{s.name}")
    end
  end

  scenario "updates his subscription successfully" do
    subscription = create(:subscription, user_id: user.id)
    visit subscriptions_path
    click_link "Edit"
    fill_in "Name", with: "Test"
    select('Eastern', :from => 'subscription[time_zone]')
    click_button "Update Subscription"
    subscription.reload
    expect(subscription.name).to eq "Test"
  end

  scenario "deletes his subscription successfully" do
    create(:subscription, user_id: user.id, active: false)
    visit subscriptions_path
    click_link "Delete"
    expect(Subscription.count).to eq 0
  end

  scenario "pauses his subscription successfully" do
    create(:subscription, user_id: user.id, active: true)
    visit subscriptions_path
    click_link "Pause Subscription"
    expect(Subscription.first.active).to eq false
  end
end
