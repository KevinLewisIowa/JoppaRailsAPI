require "test_helper"

class ClientDebtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_debt = client_debts(:one)
  end

  test "should get index" do
    get client_debts_url, as: :json
    assert_response :success
  end

  test "should create client_debt" do
    assert_difference('ClientDebt.count') do
      post client_debts_url, params: { client_debt: { amount: @client_debt.amount, client_id: @client_debt.client_id, debt_type: @client_debt.debt_type, notes: @client_debt.notes } }, as: :json
    end

    assert_response 201
  end

  test "should show client_debt" do
    get client_debt_url(@client_debt), as: :json
    assert_response :success
  end

  test "should update client_debt" do
    patch client_debt_url(@client_debt), params: { client_debt: { amount: @client_debt.amount, client_id: @client_debt.client_id, debt_type: @client_debt.debt_type, notes: @client_debt.notes } }, as: :json
    assert_response 200
  end

  test "should destroy client_debt" do
    assert_difference('ClientDebt.count', -1) do
      delete client_debt_url(@client_debt), as: :json
    end

    assert_response 204
  end
end
