require 'test_helper'

class RouteInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route_instance = route_instances(:one)
  end

  test "should get index" do
    get route_instances_url, as: :json
    assert_response :success
  end

  test "should create route_instance" do
    assert_difference('RouteInstance.count') do
      post route_instances_url, params: { route_instance: { end_time: @route_instance.end_time, heat_route: @route_instance.heat_route, leader_name: @route_instance.leader_name, leader_phone: @route_instance.leader_phone, route_id: @route_instance.route_id, start_time: @route_instance.start_time } }, as: :json
    end

    assert_response 201
  end

  test "should show route_instance" do
    get route_instance_url(@route_instance), as: :json
    assert_response :success
  end

  test "should update route_instance" do
    patch route_instance_url(@route_instance), params: { route_instance: { end_time: @route_instance.end_time, heat_route: @route_instance.heat_route, leader_name: @route_instance.leader_name, leader_phone: @route_instance.leader_phone, route_id: @route_instance.route_id, start_time: @route_instance.start_time } }, as: :json
    assert_response 200
  end

  test "should destroy route_instance" do
    assert_difference('RouteInstance.count', -1) do
      delete route_instance_url(@route_instance), as: :json
    end

    assert_response 204
  end
end
