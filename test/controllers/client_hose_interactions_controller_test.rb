require 'test_helper'

class ClientHoseInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_hose_interaction = client_hose_interactions(:one)
  end

  test "should get index" do
    get client_hose_interactions_url, as: :json
    assert_response :success
  end

  test "should create client_hose_interaction" do
    assert_difference('ClientHoseInteraction.count') do
      post client_hose_interactions_url, params: { client_hose_interaction: { client_id: @client_hose_interaction.client_id, heater_status_id: @client_hose_interaction.heater_status_id } }, as: :json
    end

    assert_response 201
  end

  test "should show client_hose_interaction" do
    get client_hose_interaction_url(@client_hose_interaction), as: :json
    assert_response :success
  end

  test "should update client_hose_interaction" do
    patch client_hose_interaction_url(@client_hose_interaction), params: { client_hose_interaction: { client_id: @client_hose_interaction.client_id, heater_status_id: @client_hose_interaction.heater_status_id } }, as: :json
    assert_response 200
  end

  test "should destroy client_hose_interaction" do
    assert_difference('ClientHoseInteraction.count', -1) do
      delete client_hose_interaction_url(@client_hose_interaction), as: :json
    end

    assert_response 204
  end
end
