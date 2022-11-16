require "test_helper"

class ClientDwellingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_dwelling = client_dwellings(:one)
  end

  test "should get index" do
    get client_dwellings_url, as: :json
    assert_response :success
  end

  test "should create client_dwelling" do
    assert_difference('ClientDwelling.count') do
      post client_dwellings_url, params: { client_dwelling: { client_id: @client_dwelling.client_id, date_became_homeless: @client_dwelling.date_became_homeless, dwelling: @client_dwelling.dwelling, first_time_homeless: @client_dwelling.first_time_homeless, homeless_reason: @client_dwelling.homeless_reason, notes: @client_dwelling.notes } }, as: :json
    end

    assert_response 201
  end

  test "should show client_dwelling" do
    get client_dwelling_url(@client_dwelling), as: :json
    assert_response :success
  end

  test "should update client_dwelling" do
    patch client_dwelling_url(@client_dwelling), params: { client_dwelling: { client_id: @client_dwelling.client_id, date_became_homeless: @client_dwelling.date_became_homeless, dwelling: @client_dwelling.dwelling, first_time_homeless: @client_dwelling.first_time_homeless, homeless_reason: @client_dwelling.homeless_reason, notes: @client_dwelling.notes } }, as: :json
    assert_response 200
  end

  test "should destroy client_dwelling" do
    assert_difference('ClientDwelling.count', -1) do
      delete client_dwelling_url(@client_dwelling), as: :json
    end

    assert_response 204
  end
end
