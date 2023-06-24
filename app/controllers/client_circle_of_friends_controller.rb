class ClientCircleOfFriendsController < ApplicationController
  before_action :set_client_circle_of_friend, only: [:show, :update, :destroy]

  # GET /client_circle_of_friends
  def index
    @client_circle_of_friends = ClientCircleOfFriend.all

    render json: @client_circle_of_friends
  end

  # GET /client_circle_of_friends/1
  def show
    render json: @client_circle_of_friend
  end

  # POST /client_circle_of_friends
  def create
    @client_circle_of_friend = ClientCircleOfFriend.new(client_circle_of_friend_params)

    if @client_circle_of_friend.save
      render json: @client_circle_of_friend, status: :created, location: @client_circle_of_friend
    else
      render json: @client_circle_of_friend.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_circle_of_friends/1
  def update
    if @client_circle_of_friend.update(client_circle_of_friend_params)
      render json: @client_circle_of_friend
    else
      render json: @client_circle_of_friend.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_circle_of_friends/1
  def destroy
    @client_circle_of_friend.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_circle_of_friend
      @client_circle_of_friend = ClientCircleOfFriend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_circle_of_friend_params
      params.require(:client_circle_of_friend).permit(:client_id, :volunteer_name, :phone_number, :email, :notes)
    end
end
