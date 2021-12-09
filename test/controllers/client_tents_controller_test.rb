require "test_helper"

class ClientTentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_tent = client_tents(:one)
  end

  test "should get index" do
    get client_tents_url, as: :json
    assert_response :success
  end

  test "should create client_tent" do
    assert_difference('ClientTent.count') do
      post client_tents_url, params: { client_tent: { client_id: @client_tent.client_id, condition: @client_tent.condition, date_given: @client_tent.date_given, given_by: @client_tent.given_by, notes: @client_tent.notes, rejected: @client_tent.rejected, setup_by: @client_tent.setup_by, type: @client_tent.type } }, as: :json
    end

    assert_response 201
  end

  test "should show client_tent" do
    get client_tent_url(@client_tent), as: :json
    assert_response :success
  end

  test "should update client_tent" do
    patch client_tent_url(@client_tent), params: { client_tent: { client_id: @client_tent.client_id, condition: @client_tent.condition, date_given: @client_tent.date_given, given_by: @client_tent.given_by, notes: @client_tent.notes, rejected: @client_tent.rejected, setup_by: @client_tent.setup_by, type: @client_tent.type } }, as: :json
    assert_response 200
  end

  test "should destroy client_tent" do
    assert_difference('ClientTent.count', -1) do
      delete client_tent_url(@client_tent), as: :json
    end

    assert_response 204
  end
end
