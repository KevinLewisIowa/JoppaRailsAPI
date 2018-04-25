require 'test_helper'

class ClientInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_interaction = client_interactions(:one)
  end

  test "should get index" do
    get client_interactions_url, as: :json
    assert_response :success
  end

  test "should create client_interaction" do
    assert_difference('ClientInteraction.count') do
      post client_interactions_url, params: { client_interaction: { client_id: @client_interaction.client_id, location_id: @client_interaction.location_id, serviced: @client_interaction.serviced } }, as: :json
    end

    assert_response 201
  end

  test "should show client_interaction" do
    get client_interaction_url(@client_interaction), as: :json
    assert_response :success
  end

  test "should update client_interaction" do
    patch client_interaction_url(@client_interaction), params: { client_interaction: { client_id: @client_interaction.client_id, location_id: @client_interaction.location_id, serviced: @client_interaction.serviced } }, as: :json
    assert_response 200
  end

  test "should destroy client_interaction" do
    assert_difference('ClientInteraction.count', -1) do
      delete client_interaction_url(@client_interaction), as: :json
    end

    assert_response 204
  end
end
