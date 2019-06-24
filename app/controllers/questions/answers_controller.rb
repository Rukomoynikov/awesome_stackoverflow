# frozen_string_literal: true

class Questions::AnswersController < ApplicationController
  before_action :set_question, only: [:create]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def new
    @answer = Answer.new
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:text)
    end
end
