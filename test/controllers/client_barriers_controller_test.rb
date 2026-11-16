require "test_helper"

class ClientBarriersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_barrier = client_barriers(:one)
  end

  test "should get index" do
    get client_barriers_url, as: :json
    assert_response :success
  end

  test "getClientBarrierRecordsByDate filters all barriers by date and paginates" do
    PassToken.create!(api_token: "barrier-records-shared-token")
    first_barrier = ClientBarrier.create!(
      client: clients(:one),
      barrier_type: "First",
      created_at: Time.zone.parse("2024-02-01 10:00:00")
    )
    second_barrier = ClientBarrier.create!(
      client: clients(:two),
      barrier_type: "Second",
      created_at: Time.zone.parse("2024-02-01 10:00:00")
    )
    outside_barrier = ClientBarrier.create!(
      client: clients(:one),
      barrier_type: "Outside",
      created_at: Time.zone.parse("2024-02-02 00:00:00")
    )

    get "/getClientBarrierRecordsByDate",
      params: { fromDate: "2024-02-01", toDate: "2024-02-01", pageSize: "1" },
      headers: { "Authorization" => "Bearer barrier-records-shared-token" },
      as: :json

    assert_response :success
    first_page = JSON.parse(response.body)
    assert_equal [first_barrier.id], first_page["records"].map { |barrier| barrier["id"] }
    assert_equal(
      { "afterCreatedAt" => first_barrier.created_at.iso8601(6), "afterId" => first_barrier.id },
      first_page["nextCursor"]
    )

    get "/getClientBarrierRecordsByDate",
      params: {
        fromDate: "2024-02-01",
        toDate: "2024-02-01",
        pageSize: "1",
        afterCreatedAt: first_page["nextCursor"]["afterCreatedAt"],
        afterId: first_page["nextCursor"]["afterId"]
      },
      headers: { "Authorization" => "Bearer barrier-records-shared-token" },
      as: :json

    assert_response :success
    second_page = JSON.parse(response.body)
    assert_equal [second_barrier.id], second_page["records"].map { |barrier| barrier["id"] }
    assert_nil second_page["nextCursor"]
    assert_not_includes second_page["records"].map { |barrier| barrier["id"] }, outside_barrier.id
  end

  test "getClientBarrierRecordsByDate rejects invalid date ranges, page sizes, and cursors" do
    PassToken.create!(api_token: "barrier-records-validation-token")
    [
      { fromDate: "2024-02-30", toDate: "2024-02-01" },
      { fromDate: "2024-02-02", toDate: "2024-02-01" },
      { fromDate: "2024-02-01", toDate: "2024-02-02", pageSize: "501" },
      { fromDate: "2024-02-01", toDate: "2024-02-02", afterId: "1" }
    ].each do |params|
      get "/getClientBarrierRecordsByDate",
        params: params,
        headers: { "Authorization" => "Bearer barrier-records-validation-token" },
        as: :json
      assert_response :unprocessable_entity
    end
  end

  test "getClientBarriers still supports filtering by clientId" do
    get "/getClientBarriers?clientId=#{@client_barrier.client_id}", as: :json

    assert_response :success
    assert_includes JSON.parse(response.body).map { |barrier| barrier["id"] }, @client_barrier.id
  end

  test "should create client_barrier" do
    assert_difference('ClientBarrier.count') do
      post client_barriers_url, params: { client_barrier: { barrier_type: @client_barrier.barrier_type, client_id: @client_barrier.client_id, note: @client_barrier.note } }, as: :json
    end

    assert_response 201
  end

  test "should show client_barrier" do
    get client_barrier_url(@client_barrier), as: :json
    assert_response :success
  end

  test "should update client_barrier" do
    patch client_barrier_url(@client_barrier), params: { client_barrier: { barrier_type: @client_barrier.barrier_type, client_id: @client_barrier.client_id, note: @client_barrier.note } }, as: :json
    assert_response 200
  end

  test "should destroy client_barrier" do
    assert_difference('ClientBarrier.count', -1) do
      delete client_barrier_url(@client_barrier), as: :json
    end

    assert_response 204
  end
end
