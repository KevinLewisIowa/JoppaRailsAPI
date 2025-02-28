require "test_helper"

class ClientSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_skill = client_skills(:one)
  end

  test "should get index" do
    get client_skills_url, as: :json
    assert_response :success
  end

  test "should create client_skill" do
    assert_difference('ClientSkill.count') do
      post client_skills_url, params: { client_skill: { client_id: @client_skill.client_id, notes: @client_skill.notes, skill: @client_skill.skill } }, as: :json
    end

    assert_response 201
  end

  test "should show client_skill" do
    get client_skill_url(@client_skill), as: :json
    assert_response :success
  end

  test "should update client_skill" do
    patch client_skill_url(@client_skill), params: { client_skill: { client_id: @client_skill.client_id, notes: @client_skill.notes, skill: @client_skill.skill } }, as: :json
    assert_response 200
  end

  test "should destroy client_skill" do
    assert_difference('ClientSkill.count', -1) do
      delete client_skill_url(@client_skill), as: :json
    end

    assert_response 204
  end
end
