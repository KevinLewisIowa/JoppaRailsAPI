require 'test_helper'

class RouteInstanceHeaterInteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route_instance_heater_interaction = route_instance_heater_interactions(:one)
  end

  test "should get index" do
    get route_instance_heater_interactions_url, as: :json
    assert_response :success
  end

  test "should create route_instance_heater_interaction" do
    assert_difference('RouteInstanceHeaterInteraction.count') do
      post route_instance_heater_interactions_url, params: { route_instance_heater_interaction: { is_checked_out: @route_instance_heater_interaction.is_checked_out, route_instance_id: @route_instance_heater_interaction.route_instance_id } }, as: :json
    end

    assert_response 201
  end

  test "should show route_instance_heater_interaction" do
    get route_instance_heater_interaction_url(@route_instance_heater_interaction), as: :json
    assert_response :success
  end

  test "should update route_instance_heater_interaction" do
    patch route_instance_heater_interaction_url(@route_instance_heater_interaction), params: { route_instance_heater_interaction: { is_checked_out: @route_instance_heater_interaction.is_checked_out, route_instance_id: @route_instance_heater_interaction.route_instance_id } }, as: :json
    assert_response 200
  end

  test "should destroy route_instance_heater_interaction" do
    assert_difference('RouteInstanceHeaterInteraction.count', -1) do
      delete route_instance_heater_interaction_url(@route_instance_heater_interaction), as: :json
    end

    assert_response 204
  end
end
