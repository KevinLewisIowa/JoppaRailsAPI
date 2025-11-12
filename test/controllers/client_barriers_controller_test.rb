require "test_helper"

class ClientBarriersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_barrier = client_barriers(:one)
  end

  test "should get index" do
    get client_barriers_url, as: :json
    assert_response :success
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
