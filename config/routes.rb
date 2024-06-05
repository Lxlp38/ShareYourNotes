Rails.application.routes.draw do
  resources :users
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  #You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.


end
