class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
 
  def signup
    @user = User.new
  end

  def index
    @users_list = User.order(:name).page(params[:page]).per(1)
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

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Account edited successfully!'
      # change to redirect to Account page
      redirect_to @user
    else
      render 'show'
    end
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
end
