require 'rails_helper'

feature "User manages his or her subscription" do
  let(:user) { create(:user) }
  before(:each) do
    login_as user
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
        select('Eastern', :from => 'Time zone')
        select('7 am', :from => 'Select Time')
        check 'subscription_send_monday'
        click_button 'Create'
        expect(page).to have_content "Subscription created successfully."
      end
    end

    context "Unsuccessful Creation" do
      scenario "User hits subscriptino limit" do
        create_list(:subscription, 2, user_id: user.id)
        visit subscriptions_path
        click_link 'New Subscription'
        fill_in 'Name', with: 'Morning Revival'
        fill_in 'Phone number', with: '555-555-5555'
        select('Eastern', :from => 'Time zone')
        select('7 am', :from => 'Select Time')
        check 'subscription_send_monday'
        click_button 'Create'
        expect(page).to have_content("Sorry, only two subscriptions per user are allowed at this time.")
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
    select('Eastern', :from => 'Time zone')
    click_button "Update Subscription"
    subscription.reload
    expect(subscription.name).to eq "Test"
  end

  scenario "deletes his subscription successfully" do
    create(:subscription, user_id: user.id)
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

  scenario "activates his subscription successfully" do
    sub = create(:subscription, user_id: user.id)
    nexmo_client = double("nexmo_client")
    result = double("result")

    allow(Nexmo::Client).to receive(:new).and_return(nexmo_client)
    allow(nexmo_client).to receive(:send_verification_request).with(number: sub.phone_number, brand: "OpenManna").and_return(result)
    allow(result).to receive(:[]).with("status").and_return("0")
    allow(result).to receive(:[]).with("request_id").and_return("12345")

    visit subscriptions_path
    click_link "Verify"

    expect(page).to have_content("Verification Code")
    allow(nexmo_client).to receive(:check_verification_request).with(request_id: "12345", code: "1234").and_return(result)
    fill_in "Code", with: "1234"
    click_button "Verify"

    sub.reload
    expect(sub.active).to eq true
  end
end
