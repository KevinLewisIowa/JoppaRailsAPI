class ClientBarriersController < ApplicationController
  before_action :set_client_barrier, only: [:show, :update, :destroy]

  # GET /client_barriers
  def index
    @client_barriers = ClientBarrier.all

    render json: @client_barriers
  end

  # GET /client_barriers/1
  def show
    render json: @client_barrier
  end

  # POST /client_barriers
  def create
    @client_barrier = ClientBarrier.new(client_barrier_params)

    if @client_barrier.save
      render json: @client_barrier, status: :created, location: @client_barrier
    else
      render json: @client_barrier.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_barriers/1
  def update
    if @client_barrier.update(client_barrier_params)
      render json: @client_barrier
    else
      render json: @client_barrier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_barriers/1
  def destroy
    @client_barrier.destroy
  end
  
  # GET getClientBarriers?clientId={cid}
  def getClientBarriers
    @barriers = ClientBarrier.where(:client_id => params[:clientId])
    
    render json: @barriers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_barrier
      @client_barrier = ClientBarrier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_barrier_params
      params.require(:client_barrier).permit(:client_id, :barrier_type, :note)
    end
end
