require "test_helper"

class ClientReferralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_referral = client_referrals(:one)
  end

  test "should get index" do
    get client_referrals_url, as: :json
    assert_response :success
  end

  test "should create client_referral" do
    assert_difference('ClientReferral.count') do
      post client_referrals_url, params: { client_referral: { notes: @client_referral.notes, quantity: @client_referral.quantity, referral_type: @client_referral.referral_type } }, as: :json
    end

    assert_response 201
  end

  test "should show client_referral" do
    get client_referral_url(@client_referral), as: :json
    assert_response :success
  end

  test "should update client_referral" do
    patch client_referral_url(@client_referral), params: { client_referral: { notes: @client_referral.notes, quantity: @client_referral.quantity, referral_type: @client_referral.referral_type } }, as: :json
    assert_response 200
  end

  test "should destroy client_referral" do
    assert_difference('ClientReferral.count', -1) do
      delete client_referral_url(@client_referral), as: :json
    end

    assert_response 204
  end
end
