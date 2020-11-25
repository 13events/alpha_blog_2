class ArticlesController < ApplicationController
  include ApplicationHelper
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # Shows the selected article
  def show; end

  # display all articles
  def index
    if(params.has_key?(:per_page))
      @articles = Article.order(:created_at).reverse_order.page(params[:page]).per(params[:per_page])
    else
      @articles = Article.order(:created_at).reverse_order.page(params[:page])
    end
  end

  def new
    @article = Article.new
  end

  # Create new article
  def create
    # create new article and require 'article' top key, permit 'title', 'description' keys
    @article = Article.new(article_params)

    # assign current user to article id
    @article.user_id = current_user.id

    # save article to db
    @article.save

    # check for erros saving to db, otherwise redirect
    if @article.errors.count.positive?
      render 'new'
    else
      flash[:notice] = 'Article Created Successfully'
      redirect_to articles_path
    end
  end

  # find article to edit, so we can display its information in the form
  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article Edited Successfully!'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article \"#{@article.title}\" wad deleted!"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
