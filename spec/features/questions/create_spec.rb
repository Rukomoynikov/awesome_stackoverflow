# frozen_string_literal: true

require 'rails_helper'

feature 'User can create question', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the questions
", type: :feature do
  given(:user) { create(:user) }

  context 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'Asks a question' do
      visit questions_path
      click_on 'Ask question'

      fill_in 'Title', with: 'Title of a question'
      fill_in 'Text', with: 'Text of a question'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Title of a question'
    end

    scenario 'Asks a question with errors' do
      visit questions_path
      click_on 'Ask question'

      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end

  context 'Unauthenticated user' do
    scenario 'Tries to ask a question' do
      visit questions_path
      click_on 'Ask question'

      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end
end
