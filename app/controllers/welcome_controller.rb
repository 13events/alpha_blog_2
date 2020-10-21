class WelcomeController < ApplicationController
  def home
    @articles = Article.last(5)
  end

  def about; end
end
