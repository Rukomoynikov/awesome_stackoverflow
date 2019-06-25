# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question', "
  In order to delete wrong question
  As an authenticated user
  I'd like to have posibility delete question
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  context 'authenticated user' do
    context 'author of question' do
      scenario 'can delete a question' do
        sign_in(user)
        visit question_path(question)

        click_on 'Delete question'
        expect(page).to have_content 'List of questions'
      end
    end

    context 'nonauthor of question' do
      scenario 'can\'t delete a question' do
        another_user = create(:user)
        sign_in(another_user)
        visit question_path(question)

        expect(page).not_to have_link 'Delete question'
      end
    end
  end

  context 'anomymous user' do
    scenario 'can\'t delete a question' do
      visit question_path(question)

      expect(page).not_to have_link 'Delete question'
    end
  end
end
