require "test_helper"

class ClientVitalRecordsControllerTest < ActionDispatch::IntegrationTest
  test "legacy volunteer token cannot access vital records" do
    PassToken.create!(api_token: "vital-record-volunteer-token")

    get "/getClientVitalRecords?clientId=1",
      headers: { "Authorization" => "Bearer vital-record-volunteer-token" },
      as: :json

    assert_response :unauthorized
  end

  test "unauthenticated requests cannot create vital records" do
    post "/client_vital_records",
      params: { client_vital_record: { client_id: 1, document_type: "ID", entered_on: Date.current } },
      as: :json

    assert_response :unauthorized
  end
end