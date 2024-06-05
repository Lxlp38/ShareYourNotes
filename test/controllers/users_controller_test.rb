require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { created_at: @user.created_at, email: @user.email, encrypted_password: @user.encrypted_password, remeber_created_at: @user.remeber_created_at, reset_password_sent_at: @user.reset_password_sent_at, role: @user.role, university_details_id: @user.university_details_id, update_at: @user.update_at, username: @user.username } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { created_at: @user.created_at, email: @user.email, encrypted_password: @user.encrypted_password, remeber_created_at: @user.remeber_created_at, reset_password_sent_at: @user.reset_password_sent_at, role: @user.role, university_details_id: @user.university_details_id, update_at: @user.update_at, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
