class HeatersController < ApplicationController
  before_action :set_heater, only: [:show, :update, :destroy]

  # GET /heaters
  def index
    @heaters = Heater.all

    render json: @heaters
  end

  # GET /heaters/1
  def show
    render json: @heater
  end
  
  def getHeaterListing
    @heaterListing = Heater.joins(:heater_type, :heater_status).select("heater_types.type_description, heaters.serial_number, heater_statuses.status_name, heaters.status_reason, heaters.is_active, heaters.updated_at")
    
    render json: @heaterListing
  end

  # POST /heaters
  def create
    @heater = Heater.new(heater_params)

    if @heater.save
      render json: @heater, status: :created, location: @heater
    else
      render json: @heater.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heaters/1
  def update
    if @heater.update(heater_params)
      render json: @heater
    else
      render json: @heater.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heaters/1
  def destroy
    @heater.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heater
      @heater = Heater.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def heater_params
      params.require(:heater).permit(:heater_type_id, :serial_number, :heater_status_id, :is_active)
    end
end
