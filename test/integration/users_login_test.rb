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
end
