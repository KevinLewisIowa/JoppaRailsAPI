require 'test_helper'

class RouteInstanceTankHoseInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route_instance_tank_hose_interaction = route_instance_tank_hose_interactions(:one)
  end

  test "should get index" do
    get route_instance_tank_hose_interactions_url, as: :json
    assert_response :success
  end

  test "should create route_instance_tank_hose_interaction" do
    assert_difference('RouteInstanceTankHoseInteraction.count') do
      post route_instance_tank_hose_interactions_url, params: { route_instance_tank_hose_interaction: { number_hoses_in: @route_instance_tank_hose_interaction.number_hoses_in, number_hoses_out: @route_instance_tank_hose_interaction.number_hoses_out, number_tanks_in: @route_instance_tank_hose_interaction.number_tanks_in, number_tanks_out: @route_instance_tank_hose_interaction.number_tanks_out, route_instance_id: @route_instance_tank_hose_interaction.route_instance_id } }, as: :json
    end

    assert_response 201
  end

  test "should show route_instance_tank_hose_interaction" do
    get route_instance_tank_hose_interaction_url(@route_instance_tank_hose_interaction), as: :json
    assert_response :success
  end

  test "should update route_instance_tank_hose_interaction" do
    patch route_instance_tank_hose_interaction_url(@route_instance_tank_hose_interaction), params: { route_instance_tank_hose_interaction: { number_hoses_in: @route_instance_tank_hose_interaction.number_hoses_in, number_hoses_out: @route_instance_tank_hose_interaction.number_hoses_out, number_tanks_in: @route_instance_tank_hose_interaction.number_tanks_in, number_tanks_out: @route_instance_tank_hose_interaction.number_tanks_out, route_instance_id: @route_instance_tank_hose_interaction.route_instance_id } }, as: :json
    assert_response 200
  end

  test "should destroy route_instance_tank_hose_interaction" do
    assert_difference('RouteInstanceTankHoseInteraction.count', -1) do
      delete route_instance_tank_hose_interaction_url(@route_instance_tank_hose_interaction), as: :json
    end

    assert_response 204
  end
end
