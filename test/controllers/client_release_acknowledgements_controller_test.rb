require "test_helper"

class ClientReleaseAcknowledgementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_release_acknowledgement = client_release_acknowledgements(:one)
  end

  test "should get index" do
    get client_release_acknowledgements_url, as: :json
    assert_response :success
  end

  test "should create client_release_acknowledgement" do
    assert_difference('ClientReleaseAcknowledgement.count') do
      post client_release_acknowledgements_url, params: { client_release_acknowledgement: { client_id: @client_release_acknowledgement.client_id, date_acknowledged: @client_release_acknowledgement.date_acknowledged } }, as: :json
    end

    assert_response 201
  end

  test "should show client_release_acknowledgement" do
    get client_release_acknowledgement_url(@client_release_acknowledgement), as: :json
    assert_response :success
  end

  test "should update client_release_acknowledgement" do
    patch client_release_acknowledgement_url(@client_release_acknowledgement), params: { client_release_acknowledgement: { client_id: @client_release_acknowledgement.client_id, date_acknowledged: @client_release_acknowledgement.date_acknowledged } }, as: :json
    assert_response 200
  end

  test "should destroy client_release_acknowledgement" do
    assert_difference('ClientReleaseAcknowledgement.count', -1) do
      delete client_release_acknowledgement_url(@client_release_acknowledgement), as: :json
    end

    assert_response 204
  end
end
