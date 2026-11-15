require "test_helper"

class ClientVitalRecordsControllerTest < ActionDispatch::IntegrationTest
  test "legacy volunteer token can read vital records" do
    PassToken.create!(api_token: "vital-record-volunteer-token")

    get "/getClientVitalRecords?clientId=#{clients(:one).id}",
      headers: { "Authorization" => "Bearer vital-record-volunteer-token" },
      as: :json

    assert_response :success
  end

  test "unauthenticated requests cannot create vital records" do
    post "/client_vital_records",
      params: { client_vital_record: { client_id: 1, document_type: "ID", entered_on: Date.current } },
      as: :json

    assert_response :unauthorized
  end

  test "legacy volunteer token cannot create vital records" do
    PassToken.create!(api_token: "vital-record-volunteer-token")

    post "/client_vital_records",
      params: { client_vital_record: { client_id: clients(:one).id, document_type: "ID", entered_on: Date.current } },
      headers: { "Authorization" => "Bearer vital-record-volunteer-token" },
      as: :json

    assert_response :unauthorized
  end
end