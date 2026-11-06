require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get clients_url, as: :json
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post clients_url, params: { client: { birthDate: @client.birthDate, isAfterCare: @client.isAfterCare, isVeteran: @client.isVeteran, joppaApartmentNumber: @client.joppaApartmentNumber, phone: @client.phone, preferredName: @client.preferredName, shoeSize: @client.shoeSize } }, as: :json
    end

    assert_response 201
  end

  test "should show client" do
    get client_url(@client), as: :json
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { birthDate: @client.birthDate, isAfterCare: @client.isAfterCare, isVeteran: @client.isVeteran, joppaApartmentNumber: @client.joppaApartmentNumber, phone: @client.phone, preferredName: @client.preferredName, shoeSize: @client.shoeSize } }, as: :json
    assert_response 200
  end

  test "should ignore legacy dwelling updates" do
    @client.update!(dwelling: 'Legacy dwelling')

    patch client_url(@client), params: { client: { dwelling: 'New value that should be ignored' } }, as: :json

    assert_response :success
    assert_equal 'Legacy dwelling', @client.reload.dwelling
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client), as: :json
    end

    assert_response 204
  end
end
