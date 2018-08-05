require 'test_helper'

class HeatersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heater = heaters(:one)
  end

  test "should get index" do
    get heaters_url, as: :json
    assert_response :success
  end

  test "should create heater" do
    assert_difference('Heater.count') do
      post heaters_url, params: { heater: { heater_type_id: @heater.heater_type_id, serial_number: @heater.serial_number } }, as: :json
    end

    assert_response 201
  end

  test "should show heater" do
    get heater_url(@heater), as: :json
    assert_response :success
  end

  test "should update heater" do
    patch heater_url(@heater), params: { heater: { heater_type_id: @heater.heater_type_id, serial_number: @heater.serial_number } }, as: :json
    assert_response 200
  end

  test "should destroy heater" do
    assert_difference('Heater.count', -1) do
      delete heater_url(@heater), as: :json
    end

    assert_response 204
  end
end
