Rails.application.routes.draw do

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
  resources :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  #You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.
end
