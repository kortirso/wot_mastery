# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tanks, only: %i[index]

  root to: 'welcome#index'
end
