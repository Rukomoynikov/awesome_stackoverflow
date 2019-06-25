# frozen_string_literal: true

require 'rails_helper'

feature 'List of questions', "
  In order to view list of questions
  As an user
  I'd like to have posibility open page and read questions
" do
  given!(:questions) { create_list(:question, 3) }

  background { visit questions_path }

  scenario 'User can view list of questions' do
    expect(page).to have_content('Question title', minimum: 3)
  end
end
