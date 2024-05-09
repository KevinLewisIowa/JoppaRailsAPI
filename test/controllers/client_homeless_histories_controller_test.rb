require "test_helper"

class ClientHomelessHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_homeless_history = client_homeless_histories(:one)
  end

  test "should get index" do
    get client_homeless_histories_url, as: :json
    assert_response :success
  end

  test "should create client_homeless_history" do
    assert_difference('ClientHomelessHistory.count') do
      post client_homeless_histories_url, params: { client_homeless_history: { client_id: @client_homeless_history.client_id, date_became_homeless: @client_homeless_history.date_became_homeless, first_time_homeless: @client_homeless_history.first_time_homeless, note: @client_homeless_history.note, reason_for_homelessness: @client_homeless_history.reason_for_homelessness } }, as: :json
    end

    assert_response 201
  end

  test "should show client_homeless_history" do
    get client_homeless_history_url(@client_homeless_history), as: :json
    assert_response :success
  end

  test "should update client_homeless_history" do
    patch client_homeless_history_url(@client_homeless_history), params: { client_homeless_history: { client_id: @client_homeless_history.client_id, date_became_homeless: @client_homeless_history.date_became_homeless, first_time_homeless: @client_homeless_history.first_time_homeless, note: @client_homeless_history.note, reason_for_homelessness: @client_homeless_history.reason_for_homelessness } }, as: :json
    assert_response 200
  end

  test "should destroy client_homeless_history" do
    assert_difference('ClientHomelessHistory.count', -1) do
      delete client_homeless_history_url(@client_homeless_history), as: :json
    end

    assert_response 204
  end
end
