class UsersController < ApplicationController
  def signup
    @user = User.new
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

  #white list user parameters from form.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end