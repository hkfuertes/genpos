Rails.application.routes.draw do
  get 'students', to: 'students#index', name: 'students_home'
  #get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index", name: 'home'
end
