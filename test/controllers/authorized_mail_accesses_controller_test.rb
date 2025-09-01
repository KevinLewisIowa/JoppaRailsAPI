require "test_helper"

class AuthorizedMailAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @authorized_mail_access = authorized_mail_accesses(:one)
  end

  test "should get index" do
    get authorized_mail_accesses_url, as: :json
    assert_response :success
  end

  test "should create authorized_mail_access" do
    assert_difference('AuthorizedMailAccess.count') do
      post authorized_mail_accesses_url, params: { authorized_mail_access: { authorized_name: @authorized_mail_access.authorized_name, date_authorized: @authorized_mail_access.date_authorized, mailbox_id: @authorized_mail_access.mailbox_id, relation_to_client: @authorized_mail_access.relation_to_client } }, as: :json
    end

    assert_response 201
  end

  test "should show authorized_mail_access" do
    get authorized_mail_access_url(@authorized_mail_access), as: :json
    assert_response :success
  end

  test "should update authorized_mail_access" do
    patch authorized_mail_access_url(@authorized_mail_access), params: { authorized_mail_access: { authorized_name: @authorized_mail_access.authorized_name, date_authorized: @authorized_mail_access.date_authorized, mailbox_id: @authorized_mail_access.mailbox_id, relation_to_client: @authorized_mail_access.relation_to_client } }, as: :json
    assert_response 200
  end

  test "should destroy authorized_mail_access" do
    assert_difference('AuthorizedMailAccess.count', -1) do
      delete authorized_mail_access_url(@authorized_mail_access), as: :json
    end

    assert_response 204
  end
end
