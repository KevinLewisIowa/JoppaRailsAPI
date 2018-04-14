require 'test_helper'

class ClientLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_like = client_likes(:one)
  end

  test "should get index" do
    get client_likes_url, as: :json
    assert_response :success
  end

  test "should create client_like" do
    assert_difference('ClientLike.count') do
      post client_likes_url, params: { client_like: { client_id: @client_like.client_id, description: @client_like.description } }, as: :json
    end

    assert_response 201
  end

  test "should show client_like" do
    get client_like_url(@client_like), as: :json
    assert_response :success
  end

  test "should update client_like" do
    patch client_like_url(@client_like), params: { client_like: { client_id: @client_like.client_id, description: @client_like.description } }, as: :json
    assert_response 200
  end

  test "should destroy client_like" do
    assert_difference('ClientLike.count', -1) do
      delete client_like_url(@client_like), as: :json
    end

    assert_response 204
  end
end
