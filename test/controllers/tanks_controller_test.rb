require 'test_helper'

class TanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tank = tanks(:one)
  end

  test "should get index" do
    get tanks_url, as: :json
    assert_response :success
  end

  test "should create tank" do
    assert_difference('Tank.count') do
      post tanks_url, params: { tank: { serial_number: @tank.serial_number } }, as: :json
    end

    assert_response 201
  end

  test "should show tank" do
    get tank_url(@tank), as: :json
    assert_response :success
  end

  test "should update tank" do
    patch tank_url(@tank), params: { tank: { serial_number: @tank.serial_number } }, as: :json
    assert_response 200
  end

  test "should destroy tank" do
    assert_difference('Tank.count', -1) do
      delete tank_url(@tank), as: :json
    end

    assert_response 204
  end
end
