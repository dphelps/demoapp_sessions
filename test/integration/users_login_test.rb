require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
  	get new_demo_path
  	assert_template 'demos/new'
  	post demos_path, demos: { email: "", password: "" }
  	assert_template 'demos/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  end

  test "login with valid information followed by logout" do
  	get new_demo_path
  	assert_template 'demos/new'
  	post demos_path, demos: { email: users(:one).email, password: users(:one).password }
  	assert_equal session[:user_id], users(:one).id 
  	assert_redirected_to users(:one)
  	follow_redirect!
  	assert_template 'users/show'
  	assert_select "a[href=?]", login_path, count: 0
  	assert_select "a[href=?]", logout_path
  	assert_select "a[href=?]", user_path(users(:one))
  	delete logout_path
  	assert_nil session[:user_id]
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_select "a[href=?]", login_path
  	assert_select "a[href=?]", logout_path, count: 0
  	assert_select "a[href=?]", user_path(users(:one)), count: 0

  end
end
