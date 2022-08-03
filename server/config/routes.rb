Rails.application.routes.draw do
  devise_scope :teacher do
    get '/sign_in' => 'devise/sessions#new', as: :new_teacher_session
    post '/sign_in' => 'devise/sessions#create', as: :teacher_session
    delete '/sign_out' => 'devise/sessions#destroy', as: :destroy_teacher_session
    get '/teacher/edit' => 'devise/registrations#edit', as: :edit_teacher_registration
  end

  resources :classrooms
  resources :students
  root to: 'home#index'
end
