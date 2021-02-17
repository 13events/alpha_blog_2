class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def signup
    @user = User.new
  end

  def index
    @users_list = User.order(:name).page(params[:page]).per(5)
  end

  def show
    @articles = @user.articles.order(:created_at).reverse_order

    if(params.has_key?(:per_page))
      @articles = @articles.page(params[:page]).per(params[:per_page])
    else 
      @articles = @articles.page(params[:page])
    end
  end 

  def create
    # create a new user with white listed params
    @user = User.new(user_params)

    # try to save to DB
    @user.save

    # check for errors saving to DB
    if @user.errors.any?
      render 'signup'
    else
      session[:user_id] = @user.id
      flash[:notice] = 'User account created'
      redirect_to(root_path)
    end
  end

  def edit
    # return unless !logged_in? || @user != current_user

    # flash[:alert] = 'You do not have authorization to perform that action.'
    # redirect_to users_path
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Account edited successfully!'
      # change to redirect to Account page
      redirect_to @user
    else
      render 'show'
    end
  end

  def destroy
    @user.destroy
    if current_user == @user
      session[:user_id] = nil
    end
    flash[:notice] = "User and associated articles have been deleted."
    redirect_to root_path
  end

  private

  # white list user parameters from form.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  # sets the current user
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !user_is_admin?
      flash[:alert] = 'You can only edit or delete your own account.'
      redirect_to @user
    end
  end


end
