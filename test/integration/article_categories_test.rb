require 'test_helper'

class ArticleCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'John', email: 'john@example.com', password: 'password', admin: false)
    @article = Article.create(title: 'Article Title', description: 'A great new article', user_id: @user.id)
  end

  test "Articles should have categories" do
    assert @article.categories
  end
end