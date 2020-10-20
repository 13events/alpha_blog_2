class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def index
    @usersList = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def create
    #create a new user with white listed params
    @user = User.new(user_params)

    #try to save to DB
    @user.save

    #check for errors saving to DB
    if @user.errors.any?
      render 'signup'
    else 
      flash[:notice] = "User account created"
      redirect_to(root_path)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Account edited successfully!"
      #change to redirect to Account page
      redirect_to @user
    else 
      render 'show'
    end
  end
  private 
  
  #white list user parameters from form.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end