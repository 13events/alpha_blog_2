class WelcomeController < ApplicationController
  include ApplicationHelper
  def home 
    @articles = Article.last(5)
  end

  def about; end
end
