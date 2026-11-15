require "test_helper"

class ClientVitalRecordsControllerTest < ActionDispatch::IntegrationTest
  test "legacy volunteer token can read vital records" do
    PassToken.create!(api_token: "vital-record-volunteer-token")

    get "/getClientVitalRecords?clientId=#{clients(:one).id}",
      headers: { "Authorization" => "Bearer vital-record-volunteer-token" },
      as: :json

    assert_response :success
  end

  test "date-range report requires an admin token" do
    PassToken.create!(api_token: "vital-record-volunteer-token")

    get "/getClientVitalRecordsByDate?fromDate=2026-01-01&toDate=2026-12-31",
      headers: { "Authorization" => "Bearer vital-record-volunteer-token" },
      as: :json

    assert_response :unauthorized
  end

  test "date-range report filters inclusively and paginates with a bounded page size" do
    admin = Admin.create!(
      email: "vital-record-report-admin@example.com",
      password: "Current1!Pass",
      password_confirmation: "Current1!Pass",
      role: :admin,
      active: true
    )
    token = AdminToken.create!(admin: admin, token: SecureRandom.hex(16), expires_at: 1.day.from_now)
    first_record = ClientVitalRecord.create!(
      client: clients(:one),
      document_type: "ID",
      entered_on: Date.new(2026, 1, 1)
    )
    second_record = ClientVitalRecord.create!(
      client: clients(:two),
      document_type: "ID",
      entered_on: Date.new(2026, 1, 1)
    )
    ClientVitalRecord.create!(
      client: clients(:one),
      document_type: "ID",
      entered_on: Date.new(2025, 12, 31)
    )
    ClientVitalRecord.create!(
      client: clients(:two),
      document_type: "ID",
      entered_on: Date.new(2027, 1, 1)
    )

    get "/getClientVitalRecordsByDate",
      params: { fromDate: "2026-01-01", toDate: "2026-12-31", pageSize: "1" },
      headers: { "Authorization" => "Bearer #{token.token}" },
      as: :json

    assert_response :success
    first_page = JSON.parse(response.body)
    assert_equal [first_record.id], first_page["records"].map { |record| record["id"] }
    assert_equal(
      { "afterEnteredOn" => "2026-01-01", "afterId" => first_record.id },
      first_page["nextCursor"]
    )

    get "/getClientVitalRecordsByDate",
      params: {
        fromDate: "2026-01-01",
        toDate: "2026-12-31",
        pageSize: "1",
        afterEnteredOn: first_page["nextCursor"]["afterEnteredOn"],
        afterId: first_page["nextCursor"]["afterId"]
      },
      headers: { "Authorization" => "Bearer #{token.token}" },
      as: :json

    assert_response :success
    second_page = JSON.parse(response.body)
    assert_equal [second_record.id], second_page["records"].map { |record| record["id"] }
    assert_nil second_page["nextCursor"]
  end

  test "date-range report rejects invalid dates, reversed ranges, and oversized pages" do
    admin = Admin.create!(
      email: "vital-record-report-validation@example.com",
      password: "Current1!Pass",
      password_confirmation: "Current1!Pass",
      role: :admin,
      active: true
    )
    token = AdminToken.create!(admin: admin, token: SecureRandom.hex(16), expires_at: 1.day.from_now)
    headers = { "Authorization" => "Bearer #{token.token}" }

    [
      { fromDate: "2026-02-30", toDate: "2026-12-31" },
      { fromDate: "2026-12-31", toDate: "2026-01-01" },
      { fromDate: "2026-01-01", toDate: "2026-12-31", pageSize: "501" },
      { fromDate: "2026-01-01", toDate: "2026-12-31", pageSize: "0" }
    ].each do |params|
      get "/getClientVitalRecordsByDate", params: params, headers: headers, as: :json
      assert_response :unprocessable_entity
    end
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