class SessionsController < ApplicationController
  def new; end

  def create
    user = find_username
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Login successful'
      redirect_to user_path(session[:user_id])
    else
      flash.now[:alert] = 'Credentials are not valid.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out successfully'
    redirect_to root_path
  end

  private

  def white_list_login_params
    params.require(:session).permit(:username, :password)
  end

  def find_username
    User.find_by(username: params[:session][:username].downcase)
  end
end
