require "test_helper"

class ClientNextOfKinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_next_of_kin = client_next_of_kins(:one)
  end

  test "should get index" do
    get client_next_of_kins_url, as: :json
    assert_response :success
  end

  test "should create client_next_of_kin" do
    assert_difference('ClientNextOfKin.count') do
      post client_next_of_kins_url, params: { client_next_of_kin: { client_id: @client_next_of_kin.client_id, email: @client_next_of_kin.email, name: @client_next_of_kin.name, note: @client_next_of_kin.note, phone_number: @client_next_of_kin.phone_number, relation_to_client: @client_next_of_kin.relation_to_client, street_address: @client_next_of_kin.street_address } }, as: :json
    end

    assert_response 201
  end

  test "should show client_next_of_kin" do
    get client_next_of_kin_url(@client_next_of_kin), as: :json
    assert_response :success
  end

  test "should update client_next_of_kin" do
    patch client_next_of_kin_url(@client_next_of_kin), params: { client_next_of_kin: { client_id: @client_next_of_kin.client_id, email: @client_next_of_kin.email, name: @client_next_of_kin.name, note: @client_next_of_kin.note, phone_number: @client_next_of_kin.phone_number, relation_to_client: @client_next_of_kin.relation_to_client, street_address: @client_next_of_kin.street_address } }, as: :json
    assert_response 200
  end

  test "should destroy client_next_of_kin" do
    assert_difference('ClientNextOfKin.count', -1) do
      delete client_next_of_kin_url(@client_next_of_kin), as: :json
    end

    assert_response 204
  end
end
