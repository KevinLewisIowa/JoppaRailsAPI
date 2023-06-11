require "test_helper"

class ClientCircleOfFriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_circle_of_friend = client_circle_of_friends(:one)
  end

  test "should get index" do
    get client_circle_of_friends_url, as: :json
    assert_response :success
  end

  test "should create client_circle_of_friend" do
    assert_difference('ClientCircleOfFriend.count') do
      post client_circle_of_friends_url, params: { client_circle_of_friend: { email: @client_circle_of_friend.email, notes: @client_circle_of_friend.notes, phone_number: @client_circle_of_friend.phone_number, volunteer_name: @client_circle_of_friend.volunteer_name } }, as: :json
    end

    assert_response 201
  end

  test "should show client_circle_of_friend" do
    get client_circle_of_friend_url(@client_circle_of_friend), as: :json
    assert_response :success
  end

  test "should update client_circle_of_friend" do
    patch client_circle_of_friend_url(@client_circle_of_friend), params: { client_circle_of_friend: { email: @client_circle_of_friend.email, notes: @client_circle_of_friend.notes, phone_number: @client_circle_of_friend.phone_number, volunteer_name: @client_circle_of_friend.volunteer_name } }, as: :json
    assert_response 200
  end

  test "should destroy client_circle_of_friend" do
    assert_difference('ClientCircleOfFriend.count', -1) do
      delete client_circle_of_friend_url(@client_circle_of_friend), as: :json
    end

    assert_response 204
  end
end
