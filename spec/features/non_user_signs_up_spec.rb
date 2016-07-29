require 'rails_helper'

feature "Non-user signs up with Open Manna" do
  scenario "Signs up successfully" do
    visit root_path
    within ('.jumbotron') do
      click_link "Sign Up"
    end
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user[password]', with: 'helloworld'
    fill_in 'user[password_confirmation]', with: 'helloworld'
    click_button 'Sign up'
    expect(User.count).to eq 1
  end
end
