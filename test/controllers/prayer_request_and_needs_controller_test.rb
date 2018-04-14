require 'test_helper'

class PrayerRequestAndNeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prayer_request_and_need = prayer_request_and_needs(:one)
  end

  test "should get index" do
    get prayer_request_and_needs_url, as: :json
    assert_response :success
  end

  test "should create prayer_request_and_need" do
    assert_difference('PrayerRequestAndNeed.count') do
      post prayer_request_and_needs_url, params: { prayer_request_and_need: { client_id: @prayer_request_and_need.client_id, detail: @prayer_request_and_need.detail } }, as: :json
    end

    assert_response 201
  end

  test "should show prayer_request_and_need" do
    get prayer_request_and_need_url(@prayer_request_and_need), as: :json
    assert_response :success
  end

  test "should update prayer_request_and_need" do
    patch prayer_request_and_need_url(@prayer_request_and_need), params: { prayer_request_and_need: { client_id: @prayer_request_and_need.client_id, detail: @prayer_request_and_need.detail } }, as: :json
    assert_response 200
  end

  test "should destroy prayer_request_and_need" do
    assert_difference('PrayerRequestAndNeed.count', -1) do
      delete prayer_request_and_need_url(@prayer_request_and_need), as: :json
    end

    assert_response 204
  end
end
