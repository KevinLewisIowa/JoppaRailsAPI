class LocationCampsController < ApplicationController
  before_action :set_location_camp, only: [:show, :update, :destroy]

  # GET /location_camps
  def index
    @location_camps = LocationCamp.all

    render json: @location_camps
  end

  # GET /location_camps/1
  def show
    render json: @location_camp
  end

  # POST /location_camps
  def create
    @location_camp = LocationCamp.new(location_camp_params)

    if @location_camp.save
      render json: @location_camp, status: :created, location: @location_camp
    else
      render json: @location_camp.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /location_camps/1
  def update
    if @location_camp.update(location_camp_params)
      render json: @location_camp
    else
      render json: @location_camp.errors, status: :unprocessable_entity
    end
  end

  # DELETE /location_camps/1
  def destroy
    @location_camp.destroy
  end
  
  def getCampsForLocation
    @camps = LocationCamp.where(:location_id => params[:locationId]);
    
    render json: @camps
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_camp
      @location_camp = LocationCamp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_camp_params
      params.require(:location_camp).permit(:name, :location_id, :is_active)
    end
end