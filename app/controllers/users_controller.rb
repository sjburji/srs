class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    if signed_in? && author_signed_in?
      @users = User.find(:all, :order => 'CREATED_AT DESC')

      respond_to do |format|
        format.html
      end
    else
      redirect_to root_path
    end    
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    if signed_in? && current_user.id == params[:id].to_i
      @user = User.find(params[:id])

      respond_to do |format|
        format.html
      end
    else
      redirect_to root_path
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = 'SUBSCRIBE'

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/edit
  def edit
    if signed_in? && current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(root_url, :notice => "User #{@user.name} successfully Signed up ...!") }
      else
        @title = "Sign up"
        flash[:error] = "Signup error!"
        format.html { render :new }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    if signed_in? && current_user.id == params[:id].to_i
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    if signed_in? && author_signed_in?
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
      end
    else
      redirect_to root_path
    end
  end
end
