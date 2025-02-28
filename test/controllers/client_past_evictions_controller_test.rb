require "test_helper"

class ClientPastEvictionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_past_eviction = client_past_evictions(:one)
  end

  test "should get index" do
    get client_past_evictions_url, as: :json
    assert_response :success
  end

  test "should create client_past_eviction" do
    assert_difference('ClientPastEviction.count') do
      post client_past_evictions_url, params: { client_past_eviction: { client_id: @client_past_eviction.client_id, eviction_type: @client_past_eviction.eviction_type, notes: @client_past_eviction.notes, year_occurred: @client_past_eviction.year_occurred } }, as: :json
    end

    assert_response 201
  end

  test "should show client_past_eviction" do
    get client_past_eviction_url(@client_past_eviction), as: :json
    assert_response :success
  end

  test "should update client_past_eviction" do
    patch client_past_eviction_url(@client_past_eviction), params: { client_past_eviction: { client_id: @client_past_eviction.client_id, eviction_type: @client_past_eviction.eviction_type, notes: @client_past_eviction.notes, year_occurred: @client_past_eviction.year_occurred } }, as: :json
    assert_response 200
  end

  test "should destroy client_past_eviction" do
    assert_difference('ClientPastEviction.count', -1) do
      delete client_past_eviction_url(@client_past_eviction), as: :json
    end

    assert_response 204
  end
end
