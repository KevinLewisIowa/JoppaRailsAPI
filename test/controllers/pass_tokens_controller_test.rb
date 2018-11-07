require 'test_helper'

class PassTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pass_token = pass_tokens(:one)
  end

  test "should get index" do
    get pass_tokens_url, as: :json
    assert_response :success
  end

  test "should create pass_token" do
    assert_difference('PassToken.count') do
      post pass_tokens_url, params: { pass_token: { admin_password: @pass_token.admin_password, api_token: @pass_token.api_token, regular_password: @pass_token.regular_password, string: @pass_token.string, string: @pass_token.string, string: @pass_token.string } }, as: :json
    end

    assert_response 201
  end

  test "should show pass_token" do
    get pass_token_url(@pass_token), as: :json
    assert_response :success
  end

  test "should update pass_token" do
    patch pass_token_url(@pass_token), params: { pass_token: { admin_password: @pass_token.admin_password, api_token: @pass_token.api_token, regular_password: @pass_token.regular_password, string: @pass_token.string, string: @pass_token.string, string: @pass_token.string } }, as: :json
    assert_response 200
  end

  test "should destroy pass_token" do
    assert_difference('PassToken.count', -1) do
      delete pass_token_url(@pass_token), as: :json
    end

    assert_response 204
  end
end
