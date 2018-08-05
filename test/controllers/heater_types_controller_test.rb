require 'test_helper'

class HeaterTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heater_type = heater_types(:one)
  end

  test "should get index" do
    get heater_types_url, as: :json
    assert_response :success
  end

  test "should create heater_type" do
    assert_difference('HeaterType.count') do
      post heater_types_url, params: { heater_type: { type_description: @heater_type.type_description } }, as: :json
    end

    assert_response 201
  end

  test "should show heater_type" do
    get heater_type_url(@heater_type), as: :json
    assert_response :success
  end

  test "should update heater_type" do
    patch heater_type_url(@heater_type), params: { heater_type: { type_description: @heater_type.type_description } }, as: :json
    assert_response 200
  end

  test "should destroy heater_type" do
    assert_difference('HeaterType.count', -1) do
      delete heater_type_url(@heater_type), as: :json
    end

    assert_response 204
  end
end
