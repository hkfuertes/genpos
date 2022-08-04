Rails.application.routes.draw do
  devise_for :teachers, skip: [:sessions, :registrations, :passwords]

  devise_scope :teacher do
    # sessions
    get    'login',  to: 'devise/sessions#new',     as: :new_teacher_session
    post   'login',  to: 'devise/sessions#create',  as: :teacher_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_teacher_session
    # registrations
    put    '/account',  to: 'teachers/registrations#update'
    # delete '/account',  to: 'teachers/registrations#destroy'
    get    '/account',  to: 'teachers/registrations#edit',   as: :edit_teacher_registration
    patch  '/account',  to: 'teachers/registrations#update', as: :teacher_registration
    # get    '/account/cancel', to: 'teachers/registrations#cancel', as: :cancel_teacher_registration# passwords 
  end

  resources :classrooms
  resources :students
  root to: 'home#index'
end
