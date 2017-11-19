require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
  end
  
  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "Sports"}
    end
    assert_template 'categories/index'
    assert_match "Sports", response.body
  end
  
  test "invalid category submission results in failure" do 
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 0 do
      post categories_path, category: {name: ""}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title' 
    assert_select 'div.panel-body'
  end
end