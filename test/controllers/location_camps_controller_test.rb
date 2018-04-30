require 'test_helper'

class LocationCampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location_camp = location_camps(:one)
  end

  test "should get index" do
    get location_camps_url, as: :json
    assert_response :success
  end

  test "should create location_camp" do
    assert_difference('LocationCamp.count') do
      post location_camps_url, params: { location_camp: { is_active: @location_camp.is_active, location_id: @location_camp.location_id, name: @location_camp.name } }, as: :json
    end

    assert_response 201
  end

  test "should show location_camp" do
    get location_camp_url(@location_camp), as: :json
    assert_response :success
  end

  test "should update location_camp" do
    patch location_camp_url(@location_camp), params: { location_camp: { is_active: @location_camp.is_active, location_id: @location_camp.location_id, name: @location_camp.name } }, as: :json
    assert_response 200
  end

  test "should destroy location_camp" do
    assert_difference('LocationCamp.count', -1) do
      delete location_camp_url(@location_camp), as: :json
    end

    assert_response 204
  end
end
