require "test_helper"

class ClientMailboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_mailbox = client_mailboxes(:one)
  end

  test "should get index" do
    get client_mailboxes_url, as: :json
    assert_response :success
  end

  test "should create client_mailbox" do
    assert_difference('ClientMailbox.count') do
      post client_mailboxes_url, params: { client_mailbox: { client_id: @client_mailbox.client_id, mailbox_number: @client_mailbox.mailbox_number, verification_type: @client_mailbox.verification_type } }, as: :json
    end

    assert_response 201
  end

  test "should show client_mailbox" do
    get client_mailbox_url(@client_mailbox), as: :json
    assert_response :success
  end

  test "should update client_mailbox" do
    patch client_mailbox_url(@client_mailbox), params: { client_mailbox: { client_id: @client_mailbox.client_id, mailbox_number: @client_mailbox.mailbox_number, verification_type: @client_mailbox.verification_type } }, as: :json
    assert_response 200
  end

  test "should destroy client_mailbox" do
    assert_difference('ClientMailbox.count', -1) do
      delete client_mailbox_url(@client_mailbox), as: :json
    end

    assert_response 204
  end
end
