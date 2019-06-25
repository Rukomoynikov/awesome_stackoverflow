# frozen_string_literal: true

require 'rails_helper'

feature 'View question', "
  In order to view question details
  As an authenticated user
  I'd like to open question page and see question
" do
  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  background do
    visit question_path(question)
  end

  scenario 'View question details' do
    expect(page).to have_content(question.title)
    expect(page).to have_content(question.text)
  end

  scenario 'View answers to a question' do
    expect(page).to have_content('Answer number', count: 3)
  end
end
