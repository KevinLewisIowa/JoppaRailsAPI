class RouteInstanceTankHoseInteractionsController < ApplicationController
  before_action :set_route_instance_tank_hose_interaction, only: [:show, :update, :destroy]

  # GET /route_instance_tank_hose_interactions
  def index
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    
    @route_instance_tank_hose_interactions = RouteInstanceTankHoseInteraction.all

    render json: @route_instance_tank_hose_interactions
  end

  # GET /route_instance_tank_hose_interactions/1
  def show
    render json: @route_instance_tank_hose_interaction
  end

  # POST /route_instance_tank_hose_interactions
  def create
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    
    @route_instance_tank_hose_interaction = RouteInstanceTankHoseInteraction.new(route_instance_tank_hose_interaction_params)

    if @route_instance_tank_hose_interaction.save
      render json: @route_instance_tank_hose_interaction, status: :created, location: @route_instance_tank_hose_interaction
    else
      render json: @route_instance_tank_hose_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /route_instance_tank_hose_interactions/1
  def update
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    
    if @route_instance_tank_hose_interaction.update(route_instance_tank_hose_interaction_params)
      render json: @route_instance_tank_hose_interaction
    else
      render json: @route_instance_tank_hose_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /route_instance_tank_hose_interactions/1
  def destroy
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    
    @route_instance_tank_hose_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_instance_tank_hose_interaction
      @route_instance_tank_hose_interaction = RouteInstanceTankHoseInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_instance_tank_hose_interaction_params
      params.require(:route_instance_tank_hose_interaction).permit(:route_instance_id, :number_hoses_out, :number_hoses_in, :number_tanks_out, :number_tanks_in)
    end
end
