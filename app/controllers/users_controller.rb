class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action RubyCAS::Filter, only: [:index]
  skip_before_action :current_user, only: [:index, :new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      render text: "NO!"
    end
  end

  # GET /users/new
  def new
    if current_user(false) 
      render text: "Nooooope"
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      render text: "NO!"
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.netid = session[:cas_user]
    @user.search_ldap(@user.netid)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id || !current_user.student
      @delete_objects = []
      @delete_objects += Vote.where(user_id: @user.id)
      @delete_objects += Flag.where(user_id: @user.id)
      @delete_objects += Post.where(user_id: @user.id)
      @delete_objects += Comment.where(user_id: @user.id)
      @delete_objects.each do |obj|
        obj.destroy
      end
      @user.destroy
      respond_to do |format|
        format.html { redirect_to log_out_path }
        format.json { head :no_content }
      end
    else
      render text: "Silly hacker!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:student, :netid, :email, :first_name, :last_name, :class_year)
    end
end
