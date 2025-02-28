require "test_helper"

class ClientFeloniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_felony = client_felonies(:one)
  end

  test "should get index" do
    get client_felonies_url, as: :json
    assert_response :success
  end

  test "should create client_felony" do
    assert_difference('ClientFelony.count') do
      post client_felonies_url, params: { client_felony: { client_id: @client_felony.client_id, felony_type: @client_felony.felony_type, notes: @client_felony.notes, year_occurred: @client_felony.year_occurred } }, as: :json
    end

    assert_response 201
  end

  test "should show client_felony" do
    get client_felony_url(@client_felony), as: :json
    assert_response :success
  end

  test "should update client_felony" do
    patch client_felony_url(@client_felony), params: { client_felony: { client_id: @client_felony.client_id, felony_type: @client_felony.felony_type, notes: @client_felony.notes, year_occurred: @client_felony.year_occurred } }, as: :json
    assert_response 200
  end

  test "should destroy client_felony" do
    assert_difference('ClientFelony.count', -1) do
      delete client_felony_url(@client_felony), as: :json
    end

    assert_response 204
  end
end
