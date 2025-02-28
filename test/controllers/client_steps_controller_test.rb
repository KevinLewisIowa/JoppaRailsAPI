require "test_helper"

class ClientStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_step = client_steps(:one)
  end

  test "should get index" do
    get client_steps_url, as: :json
    assert_response :success
  end

  test "should create client_step" do
    assert_difference('ClientStep.count') do
      post client_steps_url, params: { client_step: { client_id: @client_step.client_id, date_completed: @client_step.date_completed, notes: @client_step.notes, step_type: @client_step.step_type } }, as: :json
    end

    assert_response 201
  end

  test "should show client_step" do
    get client_step_url(@client_step), as: :json
    assert_response :success
  end

  test "should update client_step" do
    patch client_step_url(@client_step), params: { client_step: { client_id: @client_step.client_id, date_completed: @client_step.date_completed, notes: @client_step.notes, step_type: @client_step.step_type } }, as: :json
    assert_response 200
  end

  test "should destroy client_step" do
    assert_difference('ClientStep.count', -1) do
      delete client_step_url(@client_step), as: :json
    end

    assert_response 204
  end
end
