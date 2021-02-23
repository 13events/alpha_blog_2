require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_match "Create Category", response.body

    assert_difference "Category.count", 1 do
      post categories_url, params: {category: {name: 'Sports'} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category" do
    get "/categories/new"
    assert_response :success
    assert_match "Create Category", response.body

    assert_no_difference "Category.count" do
      post categories_url, params: {category: {name: ''} }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h5.alert-heading'

  end
end