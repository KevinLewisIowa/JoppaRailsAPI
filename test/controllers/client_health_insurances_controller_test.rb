require "test_helper"

class ClientHealthInsurancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_health_insurance = client_health_insurances(:one)
  end

  test "should get index" do
    get client_health_insurances_url, as: :json
    assert_response :success
  end

  test "should create client_health_insurance" do
    assert_difference('ClientHealthInsurance.count') do
      post client_health_insurances_url, params: { client_health_insurance: { client_id: @client_health_insurance.client_id, company: @client_health_insurance.company, has_health_insurance: @client_health_insurance.has_health_insurance } }, as: :json
    end

    assert_response 201
  end

  test "should show client_health_insurance" do
    get client_health_insurance_url(@client_health_insurance), as: :json
    assert_response :success
  end

  test "should update client_health_insurance" do
    patch client_health_insurance_url(@client_health_insurance), params: { client_health_insurance: { client_id: @client_health_insurance.client_id, company: @client_health_insurance.company, has_health_insurance: @client_health_insurance.has_health_insurance } }, as: :json
    assert_response 200
  end

  test "should destroy client_health_insurance" do
    assert_difference('ClientHealthInsurance.count', -1) do
      delete client_health_insurance_url(@client_health_insurance), as: :json
    end

    assert_response 204
  end
end
