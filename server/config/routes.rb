Rails.application.routes.draw do
  devise_for :teachers, skip: [:sessions, :registrations, :passwords]

  devise_scope :teacher do
    # sessions
    get    'login',  to: 'devise/sessions#new',     as: :new_teacher_session
    post   'login',  to: 'devise/sessions#create',  as: :teacher_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_teacher_session
    # registrations
    put    '/account',  to: 'devise/registrations#update'
    # delete '/account',  to: 'devise/registrations#destroy'
    get    '/account',  to: 'devise/registrations#edit',   as: :edit_teacher_registration
    patch  '/account',  to: 'devise/registrations#update', as: :teacher_registration
    # get    '/account/cancel', to: 'devise/registrations#cancel', as: :cancel_teacher_registration# passwords 
  end

  resources :classrooms
  resources :students
  root to: 'home#index'
end
