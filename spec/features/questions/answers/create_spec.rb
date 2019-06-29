# frozen_string_literal: true

require 'rails_helper'

feature 'User can add answer to question', "
  In order to delete wrong answer
  As an authenticated user
  I'd like to have posibility delete answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  context 'authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can add an answer' do
      fill_in 'Text', with: 'This is a one best comment'
      click_on 'Create Answer'

      expect(page).to have_content 'This is a one best comment'
    end

    scenario 'can\'t add add an answer with errors' do
      click_on 'Create Answer'

      expect(page).to have_content("Text can't be blank")
    end
  end

  context 'anomymous user' do
    scenario "can't add a new answer" do
      visit question_path(question)
      click_on 'Create Answer'
      fill_in 'Text', with: 'Text of new comment'

      expect(page).to have_content("Text can't be blank")
    end
  end
end
