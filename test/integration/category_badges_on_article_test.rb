require 'test_helper'

class CategoryBadgesOnArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'John', email: 'john@example.com', password: 'password', admin: false)
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "LifeStyle")
    @article = Article.create(title: 'Article Title', description: 'A great new article', user_id: @user.id, category_ids: [@category.id, @category2.id])
  end

  test "Category badges show on article index page" do
    get '/articles/'
    assert_select 'span[class=?]', 'badge bg-primary text-light', text: @category.name
  end

  test "Category badges show on article show page" do
    get article_path(@article)
    assert_select 'span[class=?]', 'badge bg-primary text-light', text: @category.name
  end

  test "Category badges show on article in reset posts on home page" do
    get root_path
    assert_select 'span[class=?]', 'badge bg-primary text-light', msg: "Badge should show on homepage", text: @category.name
  end
end