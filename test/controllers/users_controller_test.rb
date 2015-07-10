require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { color: @user.color, deleted: @user.deleted, has_files: @user.has_files, is_admin: @user.is_admin, is_owner: @user.is_owner, name: @user.name, profile_email: @user.profile_email, profile_first_name: @user.profile_first_name, profile_image_192: @user.profile_image_192, profile_image_24: @user.profile_image_24, profile_image_32: @user.profile_image_32, profile_image_48: @user.profile_image_48, profile_image_72: @user.profile_image_72, profile_last_name: @user.profile_last_name, profile_phone: @user.profile_phone, profile_real_name: @user.profile_real_name, profile_skype: @user.profile_skype, user_id: @user.user_id }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { color: @user.color, deleted: @user.deleted, has_files: @user.has_files, is_admin: @user.is_admin, is_owner: @user.is_owner, name: @user.name, profile_email: @user.profile_email, profile_first_name: @user.profile_first_name, profile_image_192: @user.profile_image_192, profile_image_24: @user.profile_image_24, profile_image_32: @user.profile_image_32, profile_image_48: @user.profile_image_48, profile_image_72: @user.profile_image_72, profile_last_name: @user.profile_last_name, profile_phone: @user.profile_phone, profile_real_name: @user.profile_real_name, profile_skype: @user.profile_skype, user_id: @user.user_id }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
