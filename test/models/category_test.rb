require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'sports')
  end
  test "Category should be valid" do
    assert @category.valid?
  end

  test "Name should be present" do
    @category = Category.new(name: " ")
    assert_not @category.valid?
  end

  test "Name should be unique" do
    @category.save
    @categoryDuplicate = Category.new(name: 'sports')
    assert_not @categoryDuplicate.valid?

  end

  test "Name should not be too long (> 20 chars)" do
    @categoryLongName = Category.new(name: 'a' * 30)
    assert_not @categoryLongName.valid?
  end

  test "Name should not be too short (<4 chars)" do
    @categoryShortName = Category.new(name: "aa")
    assert_not @categoryShortName.valid?
  end
end