require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @another = users(:another)
  end

  test "successful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "edit"
    email = "edit@example.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""} }
    assert flash
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "unsuccessful edit" do
    log_in_as(@another)
    get edit_user_path(@user)
    assert_redirected_to root_url
    name = "another"
    email = "another@example.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""} }
    @user.reload
    assert_not_equal name, @user.name
    assert_not_equal email, @user.email
  end


end
