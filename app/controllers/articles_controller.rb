class ArticlesController < ApplicationController

  #Shows the selected article
  def show
    @article = Article.find(params[:id])
  end

  #display all articles
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  #Create new article
  def create
    #create new article and require 'article' top key, permit 'title', 'description' keys
    @article = Article.new(params.require(:article).permit(:title, :description))
    #save article to db
    @article.save

    #check for erros saving to db, otherwise redirect
    if @article.errors.count > 0
      render 'new'
    else
      flash[:notice] = "Article Created Successfully"
      redirect_to articles_path
    end
  end
end
