class ClientPastEvictionsController < ApplicationController
  before_action :set_client_past_eviction, only: [:show, :update, :destroy]

  # GET /client_past_evictions
  def index
    @client_past_evictions = ClientPastEviction.all

    render json: @client_past_evictions
  end

  # GET /client_past_evictions/1
  def show
    render json: @client_past_eviction
  end

  # POST /client_past_evictions
  def create
    @client_past_eviction = ClientPastEviction.new(client_past_eviction_params)

    if @client_past_eviction.save
      render json: @client_past_eviction, status: :created, location: @client_past_eviction
    else
      render json: @client_past_eviction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_past_evictions/1
  def update
    if @client_past_eviction.update(client_past_eviction_params)
      render json: @client_past_eviction
    else
      render json: @client_past_eviction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_past_evictions/1
  def destroy
    @client_past_eviction.destroy
  end
  
  # GET getPastEvictions?clientId={cid}
  def getPastEvictions
    @pastEvictions = ClientPastEviction.where(:client_id => params[:clientId])
    
    render json: @pastEvictions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_past_eviction
      @client_past_eviction = ClientPastEviction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_past_eviction_params
      params.require(:client_past_eviction).permit(:client_id, :eviction_type, :year_occurred, :notes)
    end
end
