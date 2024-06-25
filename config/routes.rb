Rails.application.routes.draw do

  get 'notes/:id/admin_edit', to: 'notes#admin_edit', as: 'admin_edit_note'
  get 'suspended_notes', to: 'notes#suspended_notes', as: 'suspended_notes'

  resources :notes do
    resources :reviews
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
    get '/auth/:provider/callback', to: 'users/sessions#create', as: 'omniauth_callback'
    get '/auth/failure', to: redirect('/')
    get '/signout', to: 'users/sessions#destroy', as: 'signout'
  end

  delete '/users/:id', to: 'users#destroy', as: 'destroy_user'
  get '/users/:id/:provider/authorize', to: 'users#authorize', as: 'user_omniauth_authorize'
  get '/users/:id/:provider/unauthorize', to: 'users#authorize', as: 'user_omniauth_unauthorize'
  resources :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'notes#index'

  #You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.
end
