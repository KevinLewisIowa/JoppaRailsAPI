class ClientFeloniesController < ApplicationController
  before_action :set_client_felony, only: [:show, :update, :destroy]

  # GET /client_felonies
  def index
    @client_felonies = ClientFelony.all

    render json: @client_felonies
  end

  # GET /client_felonies/1
  def show
    render json: @client_felony
  end

  # POST /client_felonies
  def create
    @client_felony = ClientFelony.new(client_felony_params)

    if @client_felony.save
      render json: @client_felony, status: :created, location: @client_felony
    else
      render json: @client_felony.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_felonies/1
  def update
    if @client_felony.update(client_felony_params)
      render json: @client_felony
    else
      render json: @client_felony.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_felonies/1
  def destroy
    @client_felony.destroy
  end
  
  # GET getClientFelonies?clientId={cid}
  def getClientFelonies
    @felonies = ClientFelony.where(:client_id => params[:clientId])
    
    render json: @felonies
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_felony
      @client_felony = ClientFelony.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_felony_params
      params.require(:client_felony).permit(:client_id, :felony_type, :year_occurred, :notes)
    end
end
