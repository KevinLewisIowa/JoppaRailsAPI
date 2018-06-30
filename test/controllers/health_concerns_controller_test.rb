require 'test_helper'

class HealthConcernsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @health_concern = health_concerns(:one)
  end

  test "should get index" do
    get health_concerns_url, as: :json
    assert_response :success
  end

  test "should create health_concern" do
    assert_difference('HealthConcern.count') do
      post health_concerns_url, params: { health_concern: { client_id: @health_concern.client_id, description: @health_concern.description } }, as: :json
    end

    assert_response 201
  end

  test "should show health_concern" do
    get health_concern_url(@health_concern), as: :json
    assert_response :success
  end

  test "should update health_concern" do
    patch health_concern_url(@health_concern), params: { health_concern: { client_id: @health_concern.client_id, description: @health_concern.description } }, as: :json
    assert_response 200
  end

  test "should destroy health_concern" do
    assert_difference('HealthConcern.count', -1) do
      delete health_concern_url(@health_concern), as: :json
    end

    assert_response 204
  end
end
