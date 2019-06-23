require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions or answer
  As an unauthenticated user
  I'd like to be able to sign up
} do
  given(:user) { build(:user) }

  background { visit new_user_registration_path }

  context 'with valid information' do
    scenario 'can sign up' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation

      click_button 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end

  context 'with invalid information' do
    scenario 'can\'t sign up with empty fields' do
      click_button 'Sign up'

      expect(page).to have_content '2 errors prohibited this user from being saved'
    end

    scenario 'can\'t use existing email' do
      user.save

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation

      click_button 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end
end
