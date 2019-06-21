# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Questions::AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'assigns answer to be a Answer' do
      expect(assigns(:answer)).to be_a_new Answer
    end

    it 'renders template new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect {
          post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect {
          post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        }.not_to change(Answer, :count)
      end

      it 'rerenders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template :new
      end
    end
  end
end
