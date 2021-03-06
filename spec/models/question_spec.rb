# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:delete_all) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
end
