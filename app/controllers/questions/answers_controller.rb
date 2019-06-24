# frozen_string_literal: true

class Questions::AnswersController < ApplicationController
  before_action :set_question, only: [:create, :destroy]

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

  def destroy
    if answer.author.id == current_user.id
      answer.delete

      redirect_to question_path(@question)
    else
      redirect_to question_path(@question), notice: 'Sorry you can\'t delete this answer'
    end
  end

  private
    def answer
      @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
    end

    helper_method :answer

    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:text)
    end
end
