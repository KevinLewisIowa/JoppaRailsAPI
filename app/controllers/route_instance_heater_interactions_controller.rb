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
  
  # GET /getCheckedOutHeaters?routeInstanceId={id}
  def getCheckedOutHeaters
    @checked_out_heaters = RouteInstanceHeaterInteraction.joins(:heater, :route_instance).select("heaters.id, heaters.serial_number, route_instances.id").where("route_instance_heater_interactions.is_checked_out = ? AND route_instance_heater_interactions.route_instance_id = ?", true, params[:routeInstanceId])
    
    render json: @checked_out_heaters
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
      params.require(:route_instance_heater_interaction).permit(:route_instance_id, :is_checked_out)
    end
end
