class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  before_action :authenticate_user!
  protect_from_forgery prepend: true

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    #authorize! :show, @user, :message => "Not authorized as an administrator."
    if current_user == @user
      @notes = @user.notes
    else
      @notes = @user.notes.where(visibility: true)
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_account 
  end

  # GET /users/1/edit
  def edit
    #possono modificare solo gli admin e l'utente stesso
    authorize! :edit, @user, :message => "Not authorized as an administrator."

  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.build_account unless @user.account

    #authorize! :create, @user, :message => "You are not authorized to create a user"

    if @user.save
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def authorize
    @user = current_user
    provider = params[:provider]
    if @user.account[provider] == 'false'
      @user.account.update(provider => 'true')
    else
      @user.account.update(provider => 'false')
    end
    redirect_to user_url(@user)
  end

  protected
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
#      if params[:user][:password].blank?
#        params.require(:user).permit(:username, :university_details_id, :account_id, :role, :email, :reset_password_sent_at, :remember_created_at)
#      else
        params.require(:user).permit(:username, :university_details_id, :account_id, :password, :role, :created_at, :updated_at, :email, :encrypted_password, :reset_password_sent_at, :remember_created_at, :avatar, account_attributes: [:id, :github, :google_oauth2],   pdf: [] )
      #end
    end
end
