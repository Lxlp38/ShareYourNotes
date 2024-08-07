# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
     super
  end

  #POST /resource
  def create
    super do |resource|
      resource.build_account unless resource.account
      resource.save
    end
  end

   #GET /resource/edit
   def edit
     super
   end

   #PUT /resource
   def update
     super
   end

   #DELETE /resource
   def destroy
     super
   end

   def complete_registration
    @user = current_user
  end

  def finish_registration
    @user = current_user

    if @user.update(user_params)
      # Gestione salvataggio riuscito
      redirect_to authenticated_root_url, notice: "Registrazione completata con successo!"
    else
      # Gestione errori di validazione o altri casi di fallimento
      render :complete_registration # oppure redirect_to complete_registration_path, notice: "Errore durante la registrazione."
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :university_details_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password, university_details_id])
  end
  def user_params
    params.require(:user).permit(:username, :university_details_id)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
     super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
