Rails.application.routes.draw do
  constraints format: 'html' do
    devise_for :teachers, skip: %i[sessions registrations passwords]

    devise_scope :teacher do
      # sessions
      get    'login',  to: 'devise/sessions#new',     as: :new_teacher_session
      post   'login',  to: 'devise/sessions#create',  as: :teacher_session
      delete 'logout', to: 'devise/sessions#destroy', as: :destroy_teacher_session
      # registrations
      put    '/account',  to: 'teachers/registrations#update'
      # delete '/account',  to: 'teachers/registrations#destroy'
      get    '/account',  to: 'teachers/registrations#edit', as: :edit_teacher_registration

      # creating
      get '/teachers', to: 'teachers/registrations#new', as: :new_teacher_registration
      post '/teachers', to: 'teachers/registrations#create', as: :teacher_registration
      put '/teachers', to: 'teachers/registrations#update'
      delete '/teacher/:id', to: 'teachers/registrations#destroy', as: :destroy_teacher_registration

      get '/teacher/:act/:id', to: 'teachers/registrations#admin', as: :change_status_teacher_registration,
                               constraints: { act: /(promote|demote)/ }
      # get    '/account/cancel', to: 'teachers/registrations#cancel', as: :cancel_teacher_registration# passwords
    end

    resources :classrooms
    resources :students
    #resources :assestments
    get '/assestments', to: 'assestments#index', as: :assestments
    get '/assestment', to: 'assestments#edit', as: :edit_assestments
  end
  root to: 'home#index'
end
