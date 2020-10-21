class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # Shows the selected article
  def show; end

  # display all articles
  def index
    @articles = Article.order(:created_at).page(params[:page]).per(4)
    
  end

  def new
    @article = Article.new
  end

  # Create new article
  def create
    # create new article and require 'article' top key, permit 'title', 'description' keys
    @article = Article.new(article_params)

    # hardcode a user to assign to the new article (REMOVE THIS LATER)
    @article.user_id = User.first.id

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
