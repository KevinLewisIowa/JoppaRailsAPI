require "test_helper"

class ClientHomelessHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_homeless_history = client_homeless_histories(:one)
  end

  test "should get index" do
    get client_homeless_histories_url, as: :json
    assert_response :success
  end

  test "should filter index by fromDate/toDate and client_id" do
    in_range_history = ClientHomelessHistory.create!(client_id: 1, first_time_homeless: true, date_became_homeless: Date.parse('2024-01-15'), note: 'in range')
    ClientHomelessHistory.create!(client_id: 2, first_time_homeless: true, date_became_homeless: Date.parse('2024-01-20'), note: 'other client')
    ClientHomelessHistory.create!(client_id: 1, first_time_homeless: true, date_became_homeless: Date.parse('2024-02-01'), note: 'outside range')

    get client_homeless_histories_url, params: { fromDate: '2024-01-01', toDate: '2024-01-31', client_id: '1' }, as: :json

    assert_response :success
    response_ids = JSON.parse(response.body).map { |history| history['id'] }
    assert_equal [in_range_history.id], response_ids
  end

  test "should return all clients when clientId is ALLCLIENTS" do
    in_range_history = ClientHomelessHistory.create!(client_id: 1, first_time_homeless: true, date_became_homeless: Date.parse('2024-01-15'), note: 'first client')
    other_client_history = ClientHomelessHistory.create!(client_id: 2, first_time_homeless: true, date_became_homeless: Date.parse('2024-01-20'), note: 'second client')

    get client_homeless_histories_url, params: { fromDate: '2024-01-01', toDate: '2024-01-31', clientId: 'ALLCLIENTS' }, as: :json

    assert_response :success
    response_ids = JSON.parse(response.body).map { |history| history['id'] }
    assert_includes response_ids, in_range_history.id
    assert_includes response_ids, other_client_history.id
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
