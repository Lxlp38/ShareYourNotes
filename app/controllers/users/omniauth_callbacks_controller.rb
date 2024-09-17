# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    handle_auth "Google"
  end

  def github
    handle_auth "Github"
  end

  def failure
    redirect_to new_user_registration_url
  end

  def handle_auth(kind)
    if kind=="Google"
      x="Google"
    else
      x="Github"
    end
    auth_data = request.env['omniauth.auth']
    result = User.from_omniauth(auth_data)
    @user = result[:user]
    email= User.where(:email => @user.email)
    if email && @user.university_details_id.present?
      if x=="Google"
        if @user.account.google_oauth2=="false"
          flash[:warning] = "This account requires google activation before signing in."
          redirect_to new_user_session_url and return
        end
      else
        if @user.account.github=="false"
          flash[:warning] = "This account requires github activation before signing in."
          redirect_to new_user_session_url and return
        end
      end
    end
    if @user.isbanned?
      flash[:error] = "This account has been banned.\nReason: #{result[:reason]}.\nExpiration: #{result[:expiration]}"
      redirect_to new_user_session_url and return
    elsif @user.persisted?
      if @user.username.present? && @user.university_details_id.present?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
      else
        if x == 'Google'
          @user.account.google_oauth2 = "true"
        else
          @user.account.github = "true"
        end
        @user.account.save
        sign_in @user
        redirect_to complete_registration_path
      end
    else
      session["devise.#{kind.downcase}_data"] = auth_data.except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

          #session['devise.github_data'] = request.env['omniauth.auth'].except('extra')
        #@user = User.new(username: request.env['omniauth.auth']['info']['name'], email: request.env['omniauth.auth']['info']['email'], role: 'user', university_details: nil)
        #if @user.save
        #  flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
        #  sign_in_and_redirect @user, event: :authentication
        #else
        #  session['devise.github_data'] = request.env['omniauth.auth'].except('extra')
        #redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        #end


  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
