class HealthConcernsController < ApplicationController
  before_action :set_health_concern, only: [:show, :update, :destroy]

  # GET /health_concerns
  def index
    @health_concerns = HealthConcern.all

    render json: @health_concerns
  end

  # GET /health_concerns/1
  def show
    render json: @health_concern
  end

  # POST /health_concerns
  def create
    @health_concern = HealthConcern.new(health_concern_params)

    if @health_concern.save
      render json: @health_concern, status: :created, location: @health_concern
    else
      render json: @health_concern.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /health_concerns/1
  def update
    if @health_concern.update(health_concern_params)
      render json: @health_concern
    else
      render json: @health_concern.errors, status: :unprocessable_entity
    end
  end

  # DELETE /health_concerns/1
  def destroy
    @health_concern.destroy
  end
  
  # GET getClientHealthConcerns
  def getClientHealthConcerns
    @healthConcerns = HealthConcern.where(:client_id => params[:clientId]) #maybe Location.where('route_id = ?', params[:routeId])
    
    render json: @healthConcerns
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_concern
      @health_concern = HealthConcern.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def health_concern_params
      params.require(:health_concern).permit(:client_id, :description)
    end
end
