# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', "
  In order to exit
  As an auhenticated user
  I'd like to be able to sign out
" do
  given(:user) { create(:user) }

  scenario 'Authenticated user can sign out' do
    sign_in(user)

    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
