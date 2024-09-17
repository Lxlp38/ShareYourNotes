Rails.application.routes.draw do

  resources :tickets
  resources :user_reports
  resources :review_reports
  resources :note_reports

  get 'notes/:id/admin_edit', to: 'notes#admin_edit', as: 'admin_edit_note'
  get 'suspended_notes', to: 'notes#suspended_notes', as: 'suspended_notes'
  get 'banned_users', to: 'users#banned_users', as: 'banned_users'

  patch 'toggle_favorite/:note_id', to: 'notes#toggle_favorite', as: 'toggle_favorite'
  get 'favorites', to: 'notes#index_favorites', as:'favorites'
  #get 'toggle_preferate/:note_id', to: 'notes#toggle_preferate', as: 'toggle_preferate'

    get 'notes/courses_by_university', to: 'notes#courses_by_university'
  resources :notes do
    resources :reviews
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

    devise_scope :user do
      get '/users/sign_out', to: 'users/sessions#destroy'
      get '/auth/:provider/callback', to: 'users/sessions#create', as: 'omniauth_callback'
      get '/auth/failure', to: redirect('/')
      get '/signout', to: 'users/sessions#destroy', as: 'signout'
      get 'users/passwords/new', to: 'users/passwords#new', as:"new_password"
      get 'users/passwords/edit', to: 'users/passwords#edit', as:"edit_password"
      get 'complete_registration', to: 'users/registrations#complete_registration'
      get 'google_drive/select_file', to: 'google_drive#select_file'
      post 'google_drive/upload', to: 'google_drive#upload'
      patch 'finish_registration', to: 'users/registrations#finish_registration'
  end

  delete '/users/:id', to: 'users#destroy', as: 'destroy_user'
  get '/users/:id/:provider/authorize', to: 'users#authorize', as: 'user_omniauth_authorize'
  get '/users/:id/:provider/unauthorize', to: 'users#authorize', as: 'user_omniauth_unauthorize'
  #put '/users/:id/ban', to: 'users#ban', as: 'ban_user'
  resources :users do
    put :ban, on: :member
    post :sban
  end

  match '/frequently_asked' => "application#frequently_asked" , as: 'faq', via: [:get]
  match '/about_us' => "application#about_us" , as: 'about', via: [:get]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: 'notes#index', as: :authenticated_root, via: [:get]
  end

  unauthenticated do
    root to: "application#home" , as: :unauthenticated_root, via: [:get]
  end

  #get 'auth/google_oauth2/callback', to: 'googledrive#oauth2callback'

  #You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


end
