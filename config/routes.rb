# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    resources :answers, only: [:create, :new], controller: 'questions/answers'
  end
end
