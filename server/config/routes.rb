Rails.application.routes.draw do
  devise_for :teachers
  resources :classrooms
  resources :students
  root 'home#index', name: 'home'
end
