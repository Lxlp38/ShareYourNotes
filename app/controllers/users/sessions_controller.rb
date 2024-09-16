# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    @users=params[:user]
    email=@users[:email]
    @user=User.where(:email => email)
    @ban=Ban.where(:user_id => @user.ids)    
    if @ban.active == true
      respond_to do |format|
        format.html { redirect_to new_user_session_path, warning: "you are banned." }
        format.json { head :no_content }
      end
      return
    end
      
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def isbanned?
    return false if active_ban.nil?

    if active_ban.end < Time.now
      active_ban.update(active: false)
      return false
    else
      return true
    end
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
 
