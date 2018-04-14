require 'test_helper'

class CampingEquipmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camping_equipment = camping_equipments(:one)
  end

  test "should get index" do
    get camping_equipments_url, as: :json
    assert_response :success
  end

  test "should create camping_equipment" do
    assert_difference('CampingEquipment.count') do
      post camping_equipments_url, params: { camping_equipment: { is_available: @camping_equipment.is_available, joppa_number: @camping_equipment.joppa_number, name: @camping_equipment.name } }, as: :json
    end

    assert_response 201
  end

  test "should show camping_equipment" do
    get camping_equipment_url(@camping_equipment), as: :json
    assert_response :success
  end

  test "should update camping_equipment" do
    patch camping_equipment_url(@camping_equipment), params: { camping_equipment: { is_available: @camping_equipment.is_available, joppa_number: @camping_equipment.joppa_number, name: @camping_equipment.name } }, as: :json
    assert_response 200
  end

  test "should destroy camping_equipment" do
    assert_difference('CampingEquipment.count', -1) do
      delete camping_equipment_url(@camping_equipment), as: :json
    end

    assert_response 204
  end
end
