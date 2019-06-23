require 'rails_helper'

feature "Signins", %q{
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign in
}, type: :feature do
  given(:user) { create(:user) }
  background { visit new_user_session_path }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end