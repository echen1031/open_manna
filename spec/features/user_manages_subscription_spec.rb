require 'rails_helper'

feature "User manages his or her subscription" do
  let(:user) { create(:user) }
  before(:each) do
    login_as user
  end

  context "Creating subscription" do
    scenario "creates monday subscription successfully" do
      creates_a_monday_subscription
      expect(Subscription.first.send_monday).to eq true
    end

    scenario "creates tuesday subscription successfully" do
      creates_a_tuesday_subscription
      expect(Subscription.first.send_tuesday).to eq true
    end

    scenario "creates wednesday subscription successfully" do
      creates_a_wednesday_subscription
      expect(Subscription.first.send_wednesday).to eq true
    end

    scenario "creates thursday subscription successfully" do
      creates_a_thursday_subscription
      expect(Subscription.first.send_thursday).to eq true
    end

    scenario "creates friday subscription successfully" do
      creates_a_friday_subscription
      expect(Subscription.first.send_friday).to eq true
    end

    scenario "creates saturday subscription successfully" do
      creates_a_saturday_subscription
      expect(Subscription.first.send_saturday).to eq true
    end

    scenario "creates sunday subscription successfully" do
      creates_a_sunday_subscription
      expect(Subscription.first.send_sunday).to eq true
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
    #stub_request(:post, "https://api.nexmo.com/verify/json").
    #  with(:body => {"api_key"=>"60dbd52f", "api_secret"=>"aac3897e8090547d", "brand"=>"OpenManna", "number"=>"+15555555555"},
    #  :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'ruby-nexmo/4.1.0/2.2.1'}).
    #  to_return(:status => 200, :body => "", :headers => {})
    #create(:subscription, user_id: user.id)
    #visit subscriptions_path
    #click_link "Activate"
  end
end
