require "test_helper"

class ClientIncomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_income = client_incomes(:one)
  end

  test "should get index" do
    get client_incomes_url, as: :json
    assert_response :success
  end

  test "should create client_income" do
    assert_difference('ClientIncome.count') do
      post client_incomes_url, params: { client_income: { client_id: @client_income.client_id, has_income: @client_income.has_income, monthly_money: @client_income.monthly_money, what_income_from: @client_income.what_income_from } }, as: :json
    end

    assert_response 201
  end

  test "should show client_income" do
    get client_income_url(@client_income), as: :json
    assert_response :success
  end

  test "should update client_income" do
    patch client_income_url(@client_income), params: { client_income: { client_id: @client_income.client_id, has_income: @client_income.has_income, monthly_money: @client_income.monthly_money, what_income_from: @client_income.what_income_from } }, as: :json
    assert_response 200
  end

  test "should destroy client_income" do
    assert_difference('ClientIncome.count', -1) do
      delete client_income_url(@client_income), as: :json
    end

    assert_response 204
  end
end
