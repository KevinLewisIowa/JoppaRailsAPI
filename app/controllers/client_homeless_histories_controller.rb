class ClientHomelessHistoriesController < ApplicationController
  before_action :set_client_homeless_history, only: [:show, :update, :destroy]

  # GET /client_homeless_histories
  def index
    @client_homeless_histories = ClientHomelessHistory.all

    render json: @client_homeless_histories
  end

  # GET /client_homeless_histories/1
  def show
    render json: @client_homeless_history
  end

  # POST /client_homeless_histories
  def create
    @client_homeless_history = ClientHomelessHistory.new(client_homeless_history_params)

    if @client_homeless_history.save
      render json: @client_homeless_history, status: :created, location: @client_homeless_history
    else
      render json: @client_homeless_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_homeless_histories/1
  def update
    if @client_homeless_history.update(client_homeless_history_params)
      render json: @client_homeless_history
    else
      render json: @client_homeless_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_homeless_histories/1
  def destroy
    @client_homeless_history.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_homeless_history
      @client_homeless_history = ClientHomelessHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_homeless_history_params
      params.require(:client_homeless_history).permit(:client_id, :first_time_homeless, :date_became_homeless, :reason_for_homelessness, :note)
    end
end
