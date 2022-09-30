require "test_helper"

class LocationCampNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location_camp_note = location_camp_notes(:one)
  end

  test "should get index" do
    get location_camp_notes_url, as: :json
    assert_response :success
  end

  test "should create location_camp_note" do
    assert_difference('LocationCampNote.count') do
      post location_camp_notes_url, params: { location_camp_note: { location_camp_id: @location_camp_note.location_camp_id, note: @location_camp_note.note } }, as: :json
    end

    assert_response 201
  end

  test "should show location_camp_note" do
    get location_camp_note_url(@location_camp_note), as: :json
    assert_response :success
  end

  test "should update location_camp_note" do
    patch location_camp_note_url(@location_camp_note), params: { location_camp_note: { location_camp_id: @location_camp_note.location_camp_id, note: @location_camp_note.note } }, as: :json
    assert_response 200
  end

  test "should destroy location_camp_note" do
    assert_difference('LocationCampNote.count', -1) do
      delete location_camp_note_url(@location_camp_note), as: :json
    end

    assert_response 204
  end
end
