require 'test_helper'

class ClientNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_note = client_notes(:one)
  end

  test "should get index" do
    get client_notes_url, as: :json
    assert_response :success
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
