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

  test "should bulk deactivate outreach clients past the 30-day inactivity limit and preserve aftercare clients" do
    admin = Admin.create!(
      email: 'inactive-updater-admin@example.com',
      password: 'Current1!Pass',
      password_confirmation: 'Current1!Pass',
      role: :admin,
      active: true
    )
    token = AdminToken.create!(
      admin: admin,
      token: SecureRandom.hex(16),
      expires_at: 1.day.from_now
    )
    inactive_client = clients(:one)
    inactive_client.update!(
      first_name: 'InactiveUpdaterTest',
      status: 'Active',
      is_aftercare: false,
      last_interaction_date: 31.days.ago,
      current_camp_id: 42
    )
    aftercare_client = clients(:two)
    aftercare_client.update!(
      first_name: 'AftercareUpdaterTest',
      status: 'Active',
      is_aftercare: true,
      last_interaction_date: 120.days.ago,
      current_camp_id: 43
    )
    resource_center_client = Client.create!(
      first_name: 'ResourceCenterUpdaterTest',
      last_name: 'Test',
      status: 'Active',
      is_aftercare: false,
      last_interaction_date: 120.days.ago,
      current_camp_id: 449
    )

    post '/updateInactiveClients',
      params: { inactivityLimit: 30 },
      headers: { 'Authorization' => token.token },
      as: :json

    assert_response :success
    assert_equal 1, JSON.parse(response.body)['updated_count']
    assert_equal 'Inactive', inactive_client.reload.status
    assert_equal 0, inactive_client.current_camp_id
    assert_equal 'Active', aftercare_client.reload.status
    assert_equal 43, aftercare_client.current_camp_id
    assert_equal 'Active', resource_center_client.reload.status
    assert_equal 449, resource_center_client.current_camp_id
  end

  test "should default the inactivity limit to 30 days for outreach clients" do
    admin = Admin.create!(
      email: 'inactive-updater-default-admin@example.com',
      password: 'Current1!Pass',
      password_confirmation: 'Current1!Pass',
      role: :admin,
      active: true
    )
    token = AdminToken.create!(
      admin: admin,
      token: SecureRandom.hex(16),
      expires_at: 1.day.from_now
    )
    outreach_client = clients(:one)
    outreach_client.update!(
      first_name: 'DefaultInactiveUpdaterTest',
      status: 'Active',
      is_aftercare: nil,
      last_interaction_date: 31.days.ago,
      current_camp_id: 42
    )
    aftercare_client = clients(:two)
    aftercare_client.update!(
      first_name: 'DefaultAftercareUpdaterTest',
      status: 'Active',
      is_aftercare: true,
      last_interaction_date: 31.days.ago,
      current_camp_id: 43
    )

    post '/updateInactiveClients',
      headers: { 'Authorization' => token.token },
      as: :json

    assert_response :success
    assert_equal 1, JSON.parse(response.body)['updated_count']
    assert_equal 'Inactive', outreach_client.reload.status
    assert_equal 0, outreach_client.current_camp_id
    assert_equal 'Active', aftercare_client.reload.status
    assert_equal 43, aftercare_client.current_camp_id
  end

  test "should reject invalid inactivity limits" do
    admin = Admin.create!(
      email: 'inactive-updater-validation@example.com',
      password: 'Current1!Pass',
      password_confirmation: 'Current1!Pass',
      role: :admin,
      active: true
    )
    token = AdminToken.create!(
      admin: admin,
      token: SecureRandom.hex(16),
      expires_at: 1.day.from_now
    )

    post '/updateInactiveClients',
      params: { inactivityLimit: 0 },
      headers: { 'Authorization' => token.token },
      as: :json

    assert_response :unprocessable_entity
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client), as: :json
    end

    assert_response 204
  end
end
