require 'test_helper'

class HeaterStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heater_status = heater_statuses(:one)
  end

  test "should get index" do
    get heater_statuses_url, as: :json
    assert_response :success
  end

  test "should create heater_status" do
    assert_difference('HeaterStatus.count') do
      post heater_statuses_url, params: { heater_status: { status_name: @heater_status.status_name } }, as: :json
    end

    assert_response 201
  end

  test "should show heater_status" do
    get heater_status_url(@heater_status), as: :json
    assert_response :success
  end

  test "should update heater_status" do
    patch heater_status_url(@heater_status), params: { heater_status: { status_name: @heater_status.status_name } }, as: :json
    assert_response 200
  end

  test "should destroy heater_status" do
    assert_difference('HeaterStatus.count', -1) do
      delete heater_status_url(@heater_status), as: :json
    end

    assert_response 204
  end
end
