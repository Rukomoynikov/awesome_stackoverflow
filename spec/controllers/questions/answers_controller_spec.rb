# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, author: user) }
  let!(:answer) { create(:answer, question: question, author: user) }

  before do
    login(user)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves answer to correct question' do
        expect {
          post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        }.to change(user.questions.first.answers, :count).by(1)
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
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'author of answer' do
      it 'deletes the answer' do
        expect {
          delete :destroy, params: { id: answer.id }
        }.to change(Answer, :count).by(-1)
      end

      it 'redirects to the question' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'nonauthor of answer' do
      before { sign_out(user) }

      it "can't delete the question" do
        expect {
          delete :destroy, params: { id: answer.id }
        }.not_to change(Question, :count)
      end

      it 'redirects to the question' do
        delete :destroy, params: { id: answer.id }
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
