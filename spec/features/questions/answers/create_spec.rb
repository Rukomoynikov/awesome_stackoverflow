require 'rails_helper'

feature 'User can add answer to question', %q{
  In order to delete wrong answer
  As an authenticated user
  I'd like to have posibility delete answer
} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  context 'authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can add an answer' do
      within "form[action='/questions/#{ question.id }/answers']" do
        fill_in 'Text', with: 'This is a one best comment'
        click_on 'Create Answer'
      end

      expect(page).to have_content('Answer successfully added')
    end

    scenario 'can\'t add add an answer with errors' do
      click_on 'Create Answer'

      expect(page).not_to have_content('Answer successfully added')
    end
  end

  context 'anomymous user' do
    scenario 'can\'t see a form for a new answer' do
      visit question_path(question)
      click_on 'Create Answer'

      expect(page).not_to have_content('Answer successfully added')
    end
  end
end
