require 'test_helper'

class NavigationBarTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: 'John', email: 'john@example.com', password: 'password', admin: true)
    @normal_user = User.create(username: 'John2', email: 'john2@example.com', password: 'password', admin: false)
  end
  test "Categories link appears in nav bar" do
    get "/"
    assert_select 'a[href=?]', categories_path, { count: 1, text: 'Categories'} , 'Categories appears more than once.'
  end

  test "New Category link appears in profile dropdown if admin" do
    sign_in_as @admin_user
    get root_url
    assert_select 'li[class=?]', 'nav-item dropdown' do |element|
      assert_select 'a[href=?]', new_category_path, {count: 1, text: 'Create new category' }
    end
  end

  test "New category link should not appear in profile dropdown menu if not admin" do
    sign_in_as @normal_user
    get root_url
    assert_select 'li[class=?]', 'nav-item dropdown'do |elements|
      elements.each do |element|
        assert_select 'a[href=?]', new_category_path, false
      end
    end
  end
end