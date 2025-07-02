require "test_helper"

class ClientCaseworkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_caseworker = client_caseworkers(:one)
  end

  test "should get index" do
    get client_caseworkers_url, as: :json
    assert_response :success
  end

  test "should create client_caseworker" do
    assert_difference('ClientCaseworker.count') do
      post client_caseworkers_url, params: { client_caseworker: { email: @client_caseworker.email, name: @client_caseworker.name, notes: @client_caseworker.notes, organization: @client_caseworker.organization, phone: @client_caseworker.phone } }, as: :json
    end

    assert_response 201
  end

  test "should show client_caseworker" do
    get client_caseworker_url(@client_caseworker), as: :json
    assert_response :success
  end

  test "should update client_caseworker" do
    patch client_caseworker_url(@client_caseworker), params: { client_caseworker: { email: @client_caseworker.email, name: @client_caseworker.name, notes: @client_caseworker.notes, organization: @client_caseworker.organization, phone: @client_caseworker.phone } }, as: :json
    assert_response 200
  end

  test "should destroy client_caseworker" do
    assert_difference('ClientCaseworker.count', -1) do
      delete client_caseworker_url(@client_caseworker), as: :json
    end

    assert_response 204
  end
end
