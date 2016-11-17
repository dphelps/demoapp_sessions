require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user.password = @user.password_confirmation = "MyPassword"
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 255 + "cmu.edu"
  	assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?
  	end
  end

  test "email validation should reject invalid emails" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address
  		assert_not @user.valid?
  	end  	
  end

  test "should be unique and case insensitive" do
  	duplicate_user = User.new(email: @user.email.upcase, password: @user.password)
  	assert_not duplicate_user.valid?
  end

  test "password should have minimum length" do
  	@user = User.new
  	@user.email = "newvalid@cmu.edu"
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
end
