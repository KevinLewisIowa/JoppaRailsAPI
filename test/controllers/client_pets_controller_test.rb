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

  test "should create one food item per eligible client and pet type" do
    eligible_client = clients(:one)
    eligible_client.update!(first_name: 'PetFoodEligible', status: 'Active', current_camp_id: 100)
    excluded_client = clients(:two)
    excluded_client.update!(first_name: 'PetFoodExcluded', status: 'Active', current_camp_id: 449)
    @client_pet.update!(client_id: eligible_client.id, food_requested: true, pet_type: 'Dog')
    client_pets(:two).update!(client_id: eligible_client.id, food_requested: true, pet_type: 'Dog')
    ClientPet.create!(client_id: excluded_client.id, food_requested: true, pet_type: 'Cat')

    assert_difference('RequestedItem.count', 1) do
      post '/addPetFoodRequestedItems', as: :json
    end

    assert_response :success
    assert_equal 1, JSON.parse(response.body)['created_count']
    assert_equal 1, RequestedItem.where(client_id: eligible_client.id, item_description: 'Dog Food').count
    assert_equal 0, RequestedItem.where(client_id: excluded_client.id).count
  end
end
