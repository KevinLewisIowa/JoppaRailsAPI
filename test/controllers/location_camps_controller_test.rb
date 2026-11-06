require 'test_helper'

class LocationCampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location_camp = location_camps(:one)
  end

  test "should get index" do
    get location_camps_url, as: :json
    assert_response :success
  end

  test "should create location_camp" do
    assert_difference('LocationCamp.count') do
      post location_camps_url, params: { location_camp: { is_active: @location_camp.is_active, location_id: @location_camp.location_id, name: @location_camp.name } }, as: :json
    end

    assert_response 201
  end

  test "should show location_camp" do
    get location_camp_url(@location_camp), as: :json
    assert_response :success
  end

  test "should update location_camp" do
    patch location_camp_url(@location_camp), params: { location_camp: { is_active: @location_camp.is_active, location_id: @location_camp.location_id, name: @location_camp.name } }, as: :json
    assert_response 200
  end

  test "should destroy location_camp" do
    assert_difference('LocationCamp.count', -1) do
      delete location_camp_url(@location_camp), as: :json
    end

    assert_response 204
  end

  test "should paginate camp listing results" do
    get '/getPaginatedCampListing', params: { page: 1, page_size: 1 }, as: :json

    assert_response :success
    assert_equal 2, JSON.parse(response.body)['total']
    assert_equal 1, JSON.parse(response.body)['camps'].length
  end

  test "should return camp clients with summary fields" do
    client = clients(:one)
    client.update!(first_name: 'CampSummaryTest', status: 'Active', current_camp_id: @location_camp.id)

    get '/getClientsForCampSummary', params: { locationCampId: @location_camp.id }, as: :json

    assert_response :success
    result = JSON.parse(response.body).find { |item| item['id'] == client.id }
    assert_equal false, result['has_picture']
    assert_equal false, result['has_attention_note']
    assert_equal false, result['has_heating_equipment']
    assert_equal false, result['has_fulfilled_items']
  end

  test "should return active routes with stop and client counts" do
    route = routes(:one)
    route.update!(is_active: true)
    @location_camp.update!(route_id: route.id, is_active: true)

    get '/getRouteListing', as: :json

    assert_response :success
    listed_route = JSON.parse(response.body).find { |item| item['id'] == route.id }
    assert_equal 1, listed_route['number_stops']
    assert_equal 0, listed_route['number_clients']
  end

  test "should return route overview summary with heat client and pet totals" do
    route = routes(:one)
    route.update!(is_active: true)
    @location_camp.update!(route_id: route.id, is_active: true)
    client = clients(:one)
    client.update!(first_name: 'RouteOverviewTest', status: 'Active', current_camp_id: @location_camp.id)
    ClientDwelling.create!(client_id: client.id, dwelling: 'Tent')
    ClientPet.create!(client_id: client.id, pet_type: 'Dog', quantity: 2, food_requested: true)

    get '/getRouteOverviewSummary', params: { routeId: route.id, heatRoute: true }, as: :json

    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal route.id, response_body['route']['id']
    camp_summary = response_body['camps'].find { |camp| camp['id'] == @location_camp.id }
    assert_equal 1, camp_summary['number_clients_at_camp']
    assert_equal 2, response_body['pet_counts']['totals']['dogs']
  end
end
