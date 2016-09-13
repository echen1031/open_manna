require 'rails_helper'

feature "user resets password" do
  scenario "emails user when requesting password reset" do
    user = create(:user)
    email = user.email

    visit root_path
    click_link "Log In"
    click_link "Forgot your password?"
    fill_in "Email", with: email
    click_button "Send me reset password instructions"
    expect(page).to have_content("You will receive an email with instructions")
    expect(last_email.to).to eq [email]
  end

  scenario "resets password successfully" do
    user = create(:user)
    email = user.email
    new_password = "awesome123"

    visit root_path
    click_link "Log In"
    click_link "Forgot your password?"
    fill_in "Email", with: email
    click_button "Send me reset password instructions"

    link = links_in_email(last_email).first
    visit link

    fill_in "New password", with: new_password
    fill_in "Confirm your new password", with: new_password
    click_button "Change my password"
    user.reload

    visit root_path
    click_link "Log In"
    fill_in "Email", with: email
    fill_in "Password", with: new_password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
  end
end
