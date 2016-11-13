require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid" do
  	assert users(:one).valid?
  end

  test "email should be present" do
  	users(:one).email = ""
  	assert_not users(:one).valid?
  end

  test "email should not be too long" do
  	users(:one).email = "a" * 255 + "cmu.edu"
  	assert_not users(:one).valid?
  end

  test "email validation should accept valid emails" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid_address|
  		users(:one).email = valid_address
  		assert users(:one).valid?
  	end
  end

  test "email validation should reject invalid emails" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid_address|
  		users(:one).email = invalid_address
  		assert_not users(:one).valid?
  	end  	
  end

  test "should be unique and case insensitive" do
  	duplicate_user = User.new(email: users(:one).email.upcase, password: users(:one).password)
  	assert_not duplicate_user.valid?
  end
end
