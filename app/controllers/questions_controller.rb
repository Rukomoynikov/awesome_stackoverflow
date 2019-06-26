# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, except: [:index]
  before_action :set_answer, only: [:show]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update question_params
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @question.author.id == current_user.id
      @question.delete

      redirect_to questions_path
    else
      redirect_to @question, notice: 'Sorry you can\'t delete this question'
    end
  end

  private
    def set_question
      @question ||= params[:id] ? Question.find(params[:id]) : Question.new
    end

    def set_answer
      @answer ||= Answer.new
    end

    def question_params
      params.require(:question).permit(:title, :text)
    end
end
