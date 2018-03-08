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
    end

    context "Unsuccessful Creation" do
      scenario "User hits subscriptino limit" do
        create(:subscription, user_id: user.id)
        visit subscriptions_path
        click_link 'New Subscription'
        fill_in 'Name', with: 'Morning Revival'
        fill_in 'Phone number', with: '555-555-5555'
        select('Eastern', :from => 'subscription[time_zone]')
        select('7 am', :from => 'Select Time')
        check 'subscription_send_monday'
        click_button 'Create'
        expect(page).to have_content("Sorry, only one subscription per user are allowed at this time.")
        expect(Subscription.count).to eq 1
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

  context "Updating Subscription" do
    scenario "Cannot update other's subscription" do
      user_2 = create(:user)
      subscription_1= create(:subscription, user_id: user.id, name: "My subscription")
      subscription_2 = create(:subscription, user_id: user_2.id, name: "Others subscription")
      visit edit_subscription_path(subscription_2)
      expect(page).to have_content(subscription_1.name)
      expect(page).to_not have_content(subscription_2.name)
    end

    scenario "updates his own subscription successfully" do
      subscription = create(:subscription, user_id: user.id)
      visit subscriptions_path
      click_link "Edit"
      fill_in "Name", with: "Test"
      select('Eastern', :from => 'subscription[time_zone]')
      click_button "Update Subscription"
      subscription.reload
      expect(subscription.name).to eq "Test"
    end
  end

  context "Subscription Deletion" do
    scenario "successful" do
      create(:subscription, user_id: user.id, active: false)
      visit subscriptions_path
      click_link "Delete"
      expect(Subscription.count).to eq 0
    end
    scenario "successful in deleting subscription verses belonging to the subscription" do
      sub = create(:subscription, user_id: user.id, active: false)
      create(:subscription_verse, subscription_id: sub.id, user_id: user.id)
      visit subscriptions_path
      click_link "Delete"
      expect(Subscription.count).to eq 0
      expect(SubscriptionVerse.count).to eq 0
    end
  end

  scenario "pauses his subscription successfully" do
    create(:subscription, user_id: user.id, active: true)
    visit subscriptions_path
    click_link "Pause Subscription"
    expect(Subscription.first.active).to eq false
  end
end
