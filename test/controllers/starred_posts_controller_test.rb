require 'test_helper'

class StarredPostsControllerTest < ActionController::TestCase
  setup do
    @starred_post = starred_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:starred_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create starred_post" do
    assert_difference('StarredPost.count') do
      post :create, starred_post: { post_type: @starred_post.post_type, text: @starred_post.text, ts: @starred_post.ts, user: @starred_post.user }
    end

    assert_redirected_to starred_post_path(assigns(:starred_post))
  end

  test "should show starred_post" do
    get :show, id: @starred_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @starred_post
    assert_response :success
  end

  test "should update starred_post" do
    patch :update, id: @starred_post, starred_post: { post_type: @starred_post.post_type, text: @starred_post.text, ts: @starred_post.ts, user: @starred_post.user }
    assert_redirected_to starred_post_path(assigns(:starred_post))
  end

  test "should destroy starred_post" do
    assert_difference('StarredPost.count', -1) do
      delete :destroy, id: @starred_post
    end

    assert_redirected_to starred_posts_path
  end
end
