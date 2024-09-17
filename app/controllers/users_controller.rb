class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ban ]

  before_action :authenticate_user!
  protect_from_forgery prepend: true

  # GET /users or /users.json
  def index
    @users = User.all
  end

  def banned_users
    user_ids = Ban.where("active = ? AND end > ?", true, Date.today).pluck(:user_id)
    @users = User.where(id: user_ids)
  end

  # GET /users/1 or /users/1.json
  def show
    if params[:notes_per_page].nil?
      params[:notes_per_page] = 4
    end

    if params[:page_index].nil?
      params[:page_index] = 1
    end

    @user = User.find(params[:id])

    if current_user == @user
      @notes = @user.notes
    else
      @notes = @user.notes.where(visibility: true, suspended: false)
    end

    notes_per_page = params[:notes_per_page].to_i
    page_index = params[:page_index].to_i

    case params[:sort_by]
    when "title_asc"
      @notes = @notes.order("LOWER(title) ASC")
    when "title_desc"
      @notes = @notes.order("LOWER(title) DESC")
    when "created_at_asc"
      @notes = @notes.order("created_at ASC")
    when "created_at_desc"
      @notes = @notes.order("created_at DESC")
    else
      @notes = @notes.order("created_at ASC")
    end

    @notes = @notes.each_slice(notes_per_page).to_a[page_index-1]

    # Apply the limit and PDF presence filter
    #@notes = @notes.limit(4).select { |note| note.pdf.present? }
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
    @user = User.find(params[:id])

    if @user.update(user_params)
      if @user.role == '2'
        @user.remove_role :user
        @user.add_role :admin
      end
      if @user.role == '1'
        @user.remove_role :admin
        @user.add_role :user
      end

      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
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
  def sban
    @users = User.find(params[:user_id])
    @ban=Ban.where(:user_id => @users.id)
    @ban.update(active: false)

    respond_to do |format|
      format.html { redirect_to banned_users_path, notice: "User was successfully sbanned." }
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

  def ban
    reason = params[:reason]
    expiration = DateTime.new(
      params[:'expiration(1i)'].to_i,
      params[:'expiration(2i)'].to_i,
      params[:'expiration(3i)'].to_i,
      params[:'expiration(4i)'].to_i,
      params[:'expiration(5i)'].to_i
    )

    if @user.ban(reason, expiration)
      redirect_to @user, notice: 'User was successfully banned.'
    else
      redirect_to @user, alert: 'Failed to ban the user.'
    end
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
        params.require(:user).permit(:username, :university_details_id, :account_id, :password, :role, :created_at, :updated_at, :email, :encrypted_password, :reset_password_sent_at, :remember_created_at, :avatar, :trusted, :page_index, :notes_per_page, account_attributes: [:id, :github, :google_oauth2],   pdf: [])
      #end
    end
end
