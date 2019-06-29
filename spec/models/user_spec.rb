# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).dependent(:delete_all) }
  it { should have_many(:questions).dependent(:delete_all) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, author: user) }
    let(:answer) { create(:answer, author: user) }

    context 'valid user' do
      it 'is author of a question' do
        expect(user.author_of?(question)).to be_truthy
      end

      it 'is author of an answer' do
        expect(user.author_of?(answer)).to be_truthy
      end
    end

    context 'invalid user' do
      it 'is not author of a question' do
        expect(user2.author_of?(question)).to be_falsey
      end

      it 'is not author of an answer' do
        expect(user2.author_of?(answer)).to be_falsey
      end
    end
  end
end
