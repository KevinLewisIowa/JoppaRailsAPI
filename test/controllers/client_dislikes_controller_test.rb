require 'test_helper'

class ClientDislikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_dislike = client_dislikes(:one)
  end

  test "should get index" do
    get client_dislikes_url, as: :json
    assert_response :success
  end

  test "should create client_dislike" do
    assert_difference('ClientDislike.count') do
      post client_dislikes_url, params: { client_dislike: { client_id: @client_dislike.client_id, description: @client_dislike.description } }, as: :json
    end

    assert_response 201
  end

  test "should show client_dislike" do
    get client_dislike_url(@client_dislike), as: :json
    assert_response :success
  end

  test "should update client_dislike" do
    patch client_dislike_url(@client_dislike), params: { client_dislike: { client_id: @client_dislike.client_id, description: @client_dislike.description } }, as: :json
    assert_response 200
  end

  test "should destroy client_dislike" do
    assert_difference('ClientDislike.count', -1) do
      delete client_dislike_url(@client_dislike), as: :json
    end

    assert_response 204
  end
end
