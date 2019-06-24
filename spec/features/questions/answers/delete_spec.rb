require 'rails_helper'

feature 'User can delete answer', %q{
  In order to delete wrong answer
  As an authenticated user
  I'd like to have posibility delete answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user ) }

  context 'authenticated user' do
    context 'author of answer' do
      scenario 'can delete a answer' do
        sign_in(user)
        visit question_path(question)

        expect { click_on 'Delete answer' }.to change(Answer, :count).by(-1)
      end
    end

    context 'nonauthor of answer' do
      scenario 'can\'t delete a answer' do
        another_user = create(:user)
        sign_in(another_user)
        visit question_path(question)

        expect(page).not_to have_content 'Delete answer'
      end
    end
  end

  context 'anomymous user' do
    scenario 'can\'t delete a answer' do
      visit question_path(question)

      expect(page).not_to have_content 'Delete answer'
    end
  end
end
