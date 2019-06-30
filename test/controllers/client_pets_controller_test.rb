require 'test_helper'

class ClientPetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_pet = client_pets(:one)
  end

  test "should get index" do
    get client_pets_url, as: :json
    assert_response :success
  end

  test "should create client_pet" do
    assert_difference('ClientPet.count') do
      post client_pets_url, params: { client_pet: { food_requested: @client_pet.food_requested, pet_type: @client_pet.pet_type, quantity: @client_pet.quantity } }, as: :json
    end

    assert_response 201
  end

  test "should show client_pet" do
    get client_pet_url(@client_pet), as: :json
    assert_response :success
  end

  test "should update client_pet" do
    patch client_pet_url(@client_pet), params: { client_pet: { food_requested: @client_pet.food_requested, pet_type: @client_pet.pet_type, quantity: @client_pet.quantity } }, as: :json
    assert_response 200
  end

  test "should destroy client_pet" do
    assert_difference('ClientPet.count', -1) do
      delete client_pet_url(@client_pet), as: :json
    end

    assert_response 204
  end
end
