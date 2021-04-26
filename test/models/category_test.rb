require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'sports')
  end
  test 'Category should be valid' do
    assert @category.valid?
  end

  test 'Name should be present' do
    @category = Category.new(name: ' ')
    assert_not @category.valid?
  end

  test 'Name should be unique' do
    @category.save
    @category_duplicate = Category.new(name: 'sports')
    assert_not @category_duplicate.valid?
  end

  test 'Name should not be too long (> 20 chars)' do
    @category_long_name = Category.new(name: 'a' * 30)
    assert_not @category_long_name.valid?
  end

  test 'Name should not be too short (<4 chars)' do
    @category_short_name = Category.new(name: 'aa')
    assert_not @category_short_name.valid?
  end
end
