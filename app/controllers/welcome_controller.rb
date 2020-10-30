class WelcomeController < ApplicationController
  include ApplicationHelper
  def home
    redirect_to articles_path if logged_in?
    @articles = Article.last(5)
  end

  def about; end
end
