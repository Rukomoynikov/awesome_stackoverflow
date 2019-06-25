# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:delete_all) }
  it { should have_many(:questions).dependent(:delete_all) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
