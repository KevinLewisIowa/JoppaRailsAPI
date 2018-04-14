require 'test_helper'

class RequestedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requested_item = requested_items(:one)
  end

  test "should get index" do
    get requested_items_url, as: :json
    assert_response :success
  end

  test "should create requested_item" do
    assert_difference('RequestedItem.count') do
      post requested_items_url, params: { requested_item: { client_id: @requested_item.client_id, date_requested: @requested_item.date_requested, has_received: @requested_item.has_received, item_description: @requested_item.item_description } }, as: :json
    end

    assert_response 201
  end

  test "should show requested_item" do
    get requested_item_url(@requested_item), as: :json
    assert_response :success
  end

  test "should update requested_item" do
    patch requested_item_url(@requested_item), params: { requested_item: { client_id: @requested_item.client_id, date_requested: @requested_item.date_requested, has_received: @requested_item.has_received, item_description: @requested_item.item_description } }, as: :json
    assert_response 200
  end

  test "should destroy requested_item" do
    assert_difference('RequestedItem.count', -1) do
      delete requested_item_url(@requested_item), as: :json
    end

    assert_response 204
  end
end
