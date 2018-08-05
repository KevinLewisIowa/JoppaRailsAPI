require 'test_helper'

class ClientTankInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_tank_interaction = client_tank_interactions(:one)
  end

  test "should get index" do
    get client_tank_interactions_url, as: :json
    assert_response :success
  end

  test "should create client_tank_interaction" do
    assert_difference('ClientTankInteraction.count') do
      post client_tank_interactions_url, params: { client_tank_interaction: { client_id: @client_tank_interaction.client_id, tank_id: @client_tank_interaction.tank_id } }, as: :json
    end

    assert_response 201
  end

  test "should show client_tank_interaction" do
    get client_tank_interaction_url(@client_tank_interaction), as: :json
    assert_response :success
  end

  test "should update client_tank_interaction" do
    patch client_tank_interaction_url(@client_tank_interaction), params: { client_tank_interaction: { client_id: @client_tank_interaction.client_id, tank_id: @client_tank_interaction.tank_id } }, as: :json
    assert_response 200
  end

  test "should destroy client_tank_interaction" do
    assert_difference('ClientTankInteraction.count', -1) do
      delete client_tank_interaction_url(@client_tank_interaction), as: :json
    end

    assert_response 204
  end
end
