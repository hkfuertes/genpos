Rails.application.routes.draw do
  resources :classrooms
  resources :students
  root 'home#index', name: 'home'
end
