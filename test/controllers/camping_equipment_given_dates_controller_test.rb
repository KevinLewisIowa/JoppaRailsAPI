require 'test_helper'

class CampingEquipmentGivenDatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camping_equipment_given_date = camping_equipment_given_dates(:one)
  end

  test "should get index" do
    get camping_equipment_given_dates_url, as: :json
    assert_response :success
  end

  test "should create camping_equipment_given_date" do
    assert_difference('CampingEquipmentGivenDate.count') do
      post camping_equipment_given_dates_url, params: { camping_equipment_given_date: { camping_equipment_id: @camping_equipment_given_date.camping_equipment_id, client_id: @camping_equipment_given_date.client_id, date_given: @camping_equipment_given_date.date_given, has_returned: @camping_equipment_given_date.has_returned } }, as: :json
    end

    assert_response 201
  end

  test "should show camping_equipment_given_date" do
    get camping_equipment_given_date_url(@camping_equipment_given_date), as: :json
    assert_response :success
  end

  test "should update camping_equipment_given_date" do
    patch camping_equipment_given_date_url(@camping_equipment_given_date), params: { camping_equipment_given_date: { camping_equipment_id: @camping_equipment_given_date.camping_equipment_id, client_id: @camping_equipment_given_date.client_id, date_given: @camping_equipment_given_date.date_given, has_returned: @camping_equipment_given_date.has_returned } }, as: :json
    assert_response 200
  end

  test "should destroy camping_equipment_given_date" do
    assert_difference('CampingEquipmentGivenDate.count', -1) do
      delete camping_equipment_given_date_url(@camping_equipment_given_date), as: :json
    end

    assert_response 204
  end
end
