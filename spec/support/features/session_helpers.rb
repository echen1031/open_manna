module Features
  module SessionHelpers
    def creates_a_monday_subscription
      initial_setup
      check 'subscription_send_monday'
      click_button 'Create'
    end

    def creates_a_tuesday_subscription
      initial_setup
      check 'subscription_send_tuesday'
      click_button 'Create'
    end

    def creates_a_wednesday_subscription
      initial_setup
      check 'subscription_send_wednesday'
      click_button 'Create'
    end

    def creates_a_thursday_subscription
      initial_setup
      check 'subscription_send_thursday'
      click_button 'Create'
    end

    def creates_a_friday_subscription
      initial_setup
      check 'subscription_send_friday'
      click_button 'Create'
    end

    def creates_a_saturday_subscription
      initial_setup
      check 'subscription_send_saturday'
      click_button 'Create'
    end

    def creates_a_sunday_subscription
      initial_setup
      check 'subscription_send_sunday'
      click_button 'Create'
    end

    def creates_a_monday_subscription
      initial_setup
      check 'subscription_send_monday'
      click_button 'Create'
    end

    private 
    def initial_setup
      visit subscriptions_path
      click_link 'New Subscription'
      fill_in 'Name', with: 'Morning Revival'
      fill_in 'Phone number', with: '555-555-5555'
      select('Eastern', :from => 'Time zone')
      select('7 am', :from => 'Select Time')
    end
  end
end
