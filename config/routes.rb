# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers,
              only: [:create, :new, :destroy],
              shallow: true
  end
end
