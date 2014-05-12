module Admin
  
  class UsersController < ApplicationController

  	layout 'admin'

	  before_action :set_user, only: [:show, :edit, :update, :destroy]

	  # GET /users
	  # GET /users.json
	  def index
	    @users = User.paginate(:page => params[:page], :per_page => 20)
	  end

	  # GET /users/1
	  # GET /users/1.json
	  def show
	  	@user = User.find(:user_id)
	  end

	  # GET /users/new
	  def new
	    @user = User.new
	  end

	  # GET /users/1/edit
	  def edit
	  end

	  # POST /users
	  # POST /users.json
	  def create
	    @user = User.new(:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])

	    respond_to do |format|
	      if @user.save
	        format.html { redirect_to :controller => 'admin/users', notice: 'user was successfully created.' }
	      else
	        format.html { render action: 'new' }
	      end
	    end
	  end

	  # PATCH/PUT /users/1
	  # PATCH/PUT /users/1.json
	  def update

	    if user_params[:password].blank?
	      user_params.delete("password")
	      user_params.delete("password_confirmation")
	    end

	    respond_to do |format|
	      if @user.update(user_params)
	        format.html { redirect_to @user, notice: 'user was successfully updated.' }
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
	    if @user.id == 1
	      redirect_to users_url, notice: "You can't delete the main administrator!"
	    else
	      @user.destroy
	      respond_to do |format|
	        format.html { redirect_to users_url }
	        format.json { head :no_content }
	      end
	    end
	  end

	  private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_user
	      @user = User.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def user_params
	      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me)
	    end
	end


end