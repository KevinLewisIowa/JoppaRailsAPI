require 'test_helper'

class GoalsAndNextStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goals_and_next_step = goals_and_next_steps(:one)
  end

  test "should get index" do
    get goals_and_next_steps_url, as: :json
    assert_response :success
  end

  test "should create goals_and_next_step" do
    assert_difference('GoalsAndNextStep.count') do
      post goals_and_next_steps_url, params: { goals_and_next_step: { client_id: @goals_and_next_step.client_id, description: @goals_and_next_step.description, is_completed: @goals_and_next_step.is_completed } }, as: :json
    end

    assert_response 201
  end

  test "should show goals_and_next_step" do
    get goals_and_next_step_url(@goals_and_next_step), as: :json
    assert_response :success
  end

  test "should update goals_and_next_step" do
    patch goals_and_next_step_url(@goals_and_next_step), params: { goals_and_next_step: { client_id: @goals_and_next_step.client_id, description: @goals_and_next_step.description, is_completed: @goals_and_next_step.is_completed } }, as: :json
    assert_response 200
  end

  test "should destroy goals_and_next_step" do
    assert_difference('GoalsAndNextStep.count', -1) do
      delete goals_and_next_step_url(@goals_and_next_step), as: :json
    end

    assert_response 204
  end
end
