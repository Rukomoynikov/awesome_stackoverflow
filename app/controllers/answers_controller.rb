# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy]

  def create
    @answer = @question.answers.new(answer_params)

    @answer.author = current_user

    if @answer.save
      redirect_to @question, notice: 'Answer successfully added'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user&.author_of?(@answer)
      @answer.destroy

      redirect_to question_path(@answer.question)
    else
      redirect_to question_path(@answer.question), notice: "Sorry you can't delete this answer"
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
    end

    def answer_params
      params.require(:answer).permit(:text)
    end
end
