require 'test_helper'

class ClientNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_note = client_notes(:one)
  end

  test "should get index" do
    get client_notes_url, as: :json
    assert_response :success
  end

  test "should filter index by date range and client id" do
    in_range_note = ClientNote.create!(route_instance_id: 20, client_id: 1, note: 'in range', created_at: Time.zone.parse('2024-01-15 10:00:00'))
    ClientNote.create!(route_instance_id: 21, client_id: 2, note: 'other client', created_at: Time.zone.parse('2024-01-20 10:00:00'))
    ClientNote.create!(route_instance_id: 22, client_id: 1, note: 'outside range', created_at: Time.zone.parse('2024-02-01 10:00:00'))

    get client_notes_url, params: { startDate: '2024-01-01', endDate: '2024-01-31', clientId: '1' }, as: :json

    assert_response :success
    response_ids = JSON.parse(response.body).map { |note| note['id'] }
    assert_equal [in_range_note.id], response_ids
  end

  test "should return all clients when clientId is AllClients" do
    in_range_note = ClientNote.create!(route_instance_id: 23, client_id: 1, note: 'first client', created_at: Time.zone.parse('2024-01-15 10:00:00'))
    other_client_note = ClientNote.create!(route_instance_id: 24, client_id: 2, note: 'second client', created_at: Time.zone.parse('2024-01-20 10:00:00'))

    get client_notes_url, params: { startDate: '2024-01-01', endDate: '2024-01-31', clientId: 'AllClients' }, as: :json

    assert_response :success
    response_ids = JSON.parse(response.body).map { |note| note['id'] }
    assert_includes response_ids, in_range_note.id
    assert_includes response_ids, other_client_note.id
  end

  test "should create client_note" do
    assert_difference('ClientNote.count') do
      post client_notes_url, params: { client_note: { client_id: @client_note.client_id, note: @client_note.note, route_instance_id: @client_note.route_instance_id } }, as: :json
    end

    assert_response 201
  end

  test "should show client_note" do
    get client_note_url(@client_note), as: :json
    assert_response :success
  end

  test "should update client_note" do
    patch client_note_url(@client_note), params: { client_note: { client_id: @client_note.client_id, note: @client_note.note, route_instance_id: @client_note.route_instance_id } }, as: :json
    assert_response 200
  end

  test "should destroy client_note" do
    assert_difference('ClientNote.count', -1) do
      delete client_note_url(@client_note), as: :json
    end

    assert_response 204
  end
end
