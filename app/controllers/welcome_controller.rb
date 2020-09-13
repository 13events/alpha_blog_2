class WelcomeController < ApplicationController

  def home
    @articles = Article.first(5)
  end

  def about

  end

end