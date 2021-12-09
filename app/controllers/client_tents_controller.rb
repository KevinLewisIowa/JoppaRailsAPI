class ClientTentsController < ApplicationController
  before_action :set_client_tent, only: [:show, :update, :destroy]

  # GET /client_tents
  def index
    @client_tents = ClientTent.all

    render json: @client_tents
  end

  # GET /client_tents/1
  def show
    render json: @client_tent
  end

  # POST /client_tents
  def create
    @client_tent = ClientTent.new(client_tent_params)

    if @client_tent.save
      render json: @client_tent, status: :created, location: @client_tent
    else
      render json: @client_tent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_tents/1
  def update
    if @client_tent.update(client_tent_params)
      render json: @client_tent
    else
      render json: @client_tent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_tents/1
  def destroy
    @client_tent.destroy
  end
  
  # GET /getTentsForClient?clientId={id}
  def getTentsForClient
    
    @tents = ClientTent.where("client_id = ?", params[:clientId])
    render json: @tents
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_tent
      @client_tent = ClientTent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_tent_params
      params.require(:client_tent).permit(:client_id, :type, :condition, :date_given, :given_by, :setup_by, :notes, :rejected)
    end
end
