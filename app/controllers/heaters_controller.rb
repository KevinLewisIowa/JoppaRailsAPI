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
  # GET /updateHeaterClient?clientId={id}&heaterId={id}&status={id}
  def heaterClientUpdate
    @clientId = params[:clientId];
    @heaterId = params[:heaterId];
    @status = params[:status];
    
    @heater = Heater.find(@heaterId);
    if @status == 2
      @heater.current_client_id = @clientId
    end
    
    @interaction = ClientHeaterInteraction.new();
    @interaction.client_id = @clientId
    @interaction.heater_id = @heaterId
    @interaction.status_id = @status
    @interaction.save
    
    @heater.heater_status_id = @status;
    @heater.save;
    
    render json: @heater;
  end
  
  # GET /getCurrentHeatersForClient?clientId={id}
  def getCurrentHeatersForClient
    @heaters = Heater.where("current_client_id = ? AND heater_status_id = ?", params[:clientId], 2)
    
    render json: @heaters
  end
  
  # GET /getAvailableHeaters
  def getAvailableHeaters
    @heaters = Heater.where("heater_status_id = ?", 1)
    
    render json: @heaters
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
