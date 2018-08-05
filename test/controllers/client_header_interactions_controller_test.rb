require 'test_helper'

class ClientHeaderInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_header_interaction = client_header_interactions(:one)
  end

  test "should get index" do
    get client_header_interactions_url, as: :json
    assert_response :success
  end

  test "should create client_header_interaction" do
    assert_difference('ClientHeaderInteraction.count') do
      post client_header_interactions_url, params: { client_header_interaction: { client_id: @client_header_interaction.client_id, heater_id: @client_header_interaction.heater_id } }, as: :json
    end

    assert_response 201
  end

  test "should show client_header_interaction" do
    get client_header_interaction_url(@client_header_interaction), as: :json
    assert_response :success
  end

  test "should update client_header_interaction" do
    patch client_header_interaction_url(@client_header_interaction), params: { client_header_interaction: { client_id: @client_header_interaction.client_id, heater_id: @client_header_interaction.heater_id } }, as: :json
    assert_response 200
  end

  test "should destroy client_header_interaction" do
    assert_difference('ClientHeaderInteraction.count', -1) do
      delete client_header_interaction_url(@client_header_interaction), as: :json
    end

    assert_response 204
  end
end
