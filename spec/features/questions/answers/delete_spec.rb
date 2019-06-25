# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete answer', "
  In order to delete wrong answer
  As an authenticated user
  I'd like to have posibility delete answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  context 'authenticated user' do
    context 'author of answer' do
      scenario 'can delete a answer' do
        sign_in(user)
        visit question_path(question)
        click_on 'Delete answer'
        expect(page).not_to have_content answer.text
      end
    end

    context 'nonauthor of answer' do
      scenario 'can\'t delete a answer' do
        another_user = create(:user)
        sign_in(another_user)
        visit question_path(question)

        expect(page).not_to have_link 'Delete answer'
      end
    end
  end

  context 'anomymous user' do
    scenario 'can\'t delete a answer' do
      visit question_path(question)

      expect(page).not_to have_link 'Delete answer'
    end
  end
end
