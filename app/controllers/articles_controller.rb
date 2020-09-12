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

  #find article to edit, so we can display its information in the form
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article Edited Successfully!"
      redirect_to articles_path
    else 
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article \"#{@article.title}\" wad deleted!"
    redirect_to articles_path
  end

end
