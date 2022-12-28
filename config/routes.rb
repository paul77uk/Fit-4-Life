Rails.application.routes.draw do
  root 'workouts#index'
  devise_for :users
  resources :workouts
end
