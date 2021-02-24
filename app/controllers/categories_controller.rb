include ApplicationHelper
class CategoriesController < ApplicationController
  before_action :require_admin_user, except: [:show, :index]
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully!"
      redirect_to(@category)
    else
      render 'new'
    end
  end
  def index
    @categories_list = Category.order(:name).page(params[:page]).per(5)
  end
  def show
    @category = Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin_user
    if !(logged_in? && user_is_admin?)
      flash[:alert] = "You must be an admin to perform that action!"
      redirect_to categories_path
    end
  end
end