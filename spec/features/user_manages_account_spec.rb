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
end
