require "test_helper"

class ClientRentDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    admin = Admin.create!(
      email: "rent-details-admin@example.com",
      password: "Current1!Pass",
      password_confirmation: "Current1!Pass",
      role: :admin,
      active: true
    )
    @token = AdminToken.create!(admin: admin, token: SecureRandom.hex(16), expires_at: 1.day.from_now)
    @headers = { "Authorization" => "Bearer #{@token.token}" }
  end

  test "admin can create, fetch, and update one rent detail per client" do
    get "/getClientRentDetails?clientId=#{clients(:one).id}", headers: @headers, as: :json
    assert_response :not_found

    create_rent_detail

    assert_response :created
    rent_detail = JSON.parse(response.body)
    assert_equal clients(:one).id, rent_detail["client_id"]
    assert_equal "Family Member", rent_detail["who_is_paying"]

    assert_no_difference "ClientRentDetail.count" do
      create_rent_detail
    end
    assert_response :unprocessable_entity

    get "/getClientRentDetails?clientId=#{clients(:one).id}", headers: @headers, as: :json
    assert_response :success
    assert_equal rent_detail["id"], JSON.parse(response.body)["id"]

    patch "/client_rent_details/#{rent_detail['id']}",
      params: {
        client_rent_detail: {
          client_id: clients(:two).id,
          rent_cost: 875,
          utilities_included: false,
          utilities_cost: 95,
          who_is_paying: "Other Organization",
          note: "Updated"
        }
      },
      headers: @headers,
      as: :json

    assert_response :success
    updated = JSON.parse(response.body)
    assert_equal clients(:one).id, updated["client_id"]
    assert_in_delta 875, updated["rent_cost"].to_f
    assert_in_delta 95, updated["utilities_cost"].to_f
    assert_equal "Updated", updated["note"]
    assert_equal 1, ClientRentDetail.where(client_id: clients(:one).id).count
  end

  test "rent details require valid utility costs and payer values" do
    post "/client_rent_details",
      params: {
        client_rent_detail: {
          client_id: clients(:one).id,
          rent_cost: 800,
          utilities_included: false,
          who_is_paying: "Unknown"
        }
      },
      headers: @headers,
      as: :json

    assert_response :unprocessable_entity
    assert_equal 0, ClientRentDetail.where(client_id: clients(:one).id).count
  end

  test "legacy volunteer tokens cannot read or create rent details" do
    PassToken.create!(api_token: "rent-details-volunteer-token")
    volunteer_headers = { "Authorization" => "Bearer rent-details-volunteer-token" }

    get "/getClientRentDetails?clientId=#{clients(:one).id}", headers: volunteer_headers, as: :json
    assert_response :unauthorized

    post "/client_rent_details",
      params: {
        client_rent_detail: {
          client_id: clients(:one).id,
          rent_cost: 800,
          utilities_included: true,
          who_is_paying: "Self"
        }
      },
      headers: volunteer_headers,
      as: :json

    assert_response :unauthorized
  end

  private

  def create_rent_detail
    post "/client_rent_details",
      params: {
        client_rent_detail: {
          client_id: clients(:one).id,
          rent_cost: 850,
          utilities_included: true,
          utilities_cost: nil,
          who_is_paying: "Family Member",
          note: "Aftercare program"
        }
      },
      headers: @headers,
      as: :json
  end
end
