require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  setup do
    @channel = channels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:channels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create channel" do
    assert_difference('Channel.count') do
      post :create, channel: { ch_id: @channel.ch_id, created: @channel.created, creator: @channel.creator, is_archived: @channel.is_archived, name: @channel.name, num_members: @channel.num_members, purpose_creator: @channel.purpose_creator, purpose_last_set: @channel.purpose_last_set, purpose_value: @channel.purpose_value, topic_creator: @channel.topic_creator, topic_last_set: @channel.topic_last_set, topic_value: @channel.topic_value }
    end

    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should show channel" do
    get :show, id: @channel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @channel
    assert_response :success
  end

  test "should update channel" do
    patch :update, id: @channel, channel: { ch_id: @channel.ch_id, created: @channel.created, creator: @channel.creator, is_archived: @channel.is_archived, name: @channel.name, num_members: @channel.num_members, purpose_creator: @channel.purpose_creator, purpose_last_set: @channel.purpose_last_set, purpose_value: @channel.purpose_value, topic_creator: @channel.topic_creator, topic_last_set: @channel.topic_last_set, topic_value: @channel.topic_value }
    assert_redirected_to channel_path(assigns(:channel))
  end

  test "should destroy channel" do
    assert_difference('Channel.count', -1) do
      delete :destroy, id: @channel
    end

    assert_redirected_to channels_path
  end
end
