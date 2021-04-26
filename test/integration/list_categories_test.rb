require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'John', email: 'john@example.com', password: 'password', admin: false)
    @travel_category = Category.create(name: "Travel")
    @sports_category = Category.create(name: "Sports")
    @travel_article = Article.create(title: 'Article Title', description: 'A great new article', user_id: @user.id, category_ids: @travel_category.id)
    @travel_article_2 = Article.create(title: 'Second Article Title', description: 'A great second  article', user_id: @user.id, category_ids: @travel_category.id)
    @sports_article = Article.create(title: 'Article about sports', description: 'A great sports article', user_id: @user.id, category_ids: @sports_category.id)
  end

  test 'should show categories listing' do
    get '/categories/'
    assert_select 'a[href=?]', category_path(@travel_category), text: @travel_category.name
    assert_select 'a[href=?]', category_path(@sports_category), text: @sports_category.name
  end

  test "category Travel displays 2 articles associated with it" do
    get '/categories/'
    assert_select 'p[class=?]', 'card-text', text: "2 articles"
  end

  test "should display 2 articles on Sports category show page" do
    get category_path(@sports_category)
    assert_match @sports_article.title, response.body
  end

end