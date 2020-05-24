# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tanks, only: %i[index]
    end
  end

  localized do
    root to: 'welcome#index'
  end
end
