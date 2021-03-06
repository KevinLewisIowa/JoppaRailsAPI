class RouteInstanceHeaterInteractionsController < ApplicationController
  before_action :set_route_instance_heater_interaction, only: [:show, :update, :destroy]

  # GET /route_instance_heater_interactions
  def index
    @route_instance_heater_interactions = RouteInstanceHeaterInteraction.all

    render json: @route_instance_heater_interactions
  end

  # GET /route_instance_heater_interactions/1
  def show
    render json: @route_instance_heater_interaction
  end
  
  # PATCH/PUT /checkInAllHeaters
  def checkInAllHeaters
    @numCheckedInHeaters = RouteInstanceHeaterInteraction.where('is_checked_out = ?', true).update_all(is_checked_out: false)
    
    render json: @numCheckedInHeaters
  end
  
  # GET /getCheckedOutHeaters?routeInstanceId={id}
  def getCheckedOutHeaters
    @checked_out_heaters = RouteInstanceHeaterInteraction.joins(:heater).select("route_instance_heater_interactions.id, route_instance_heater_interactions.heater_id, heaters.serial_number, route_instance_heater_interactions.route_instance_id, route_instance_heater_interactions.is_checked_out").where("route_instance_heater_interactions.is_checked_out = ? AND route_instance_heater_interactions.route_instance_id = ?", true, params[:routeInstanceId])
    
    render json: @checked_out_heaters
  end
  
  # GET /isHeaterCheckedOutOnOtherRoute?heaterId={heaterId}
  def isHeaterCheckedOutOnOtherRoute
    @routeInstancesWhereCheckedOut = RouteInstanceHeaterInteraction.select("route_instance_heater_interactions.route_instance_id").where("route_instance_heater_interactions.heater_id = ? AND route_instance_heater_interactions.is_checked_out = ?", params[:heaterId], true)
    
    render json: @routeInstancesWhereCheckedOut
  end

  # POST /route_instance_heater_interactions
  def create
    @route_instance_heater_interaction = RouteInstanceHeaterInteraction.new(route_instance_heater_interaction_params)

    if @route_instance_heater_interaction.save
      render json: @route_instance_heater_interaction, status: :created, location: @route_instance_heater_interaction
    else
      render json: @route_instance_heater_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /route_instance_heater_interactions/1
  def update
    if @route_instance_heater_interaction.update(route_instance_heater_interaction_params)
      render json: @route_instance_heater_interaction
    else
      render json: @route_instance_heater_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /route_instance_heater_interactions/1
  def destroy
    @route_instance_heater_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_instance_heater_interaction
      @route_instance_heater_interaction = RouteInstanceHeaterInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_instance_heater_interaction_params
      params.require(:route_instance_heater_interaction).permit(:route_instance_id, :heater_id, :is_checked_out)
    end
end
