class ClientTankInteractionsController < ApplicationController
  before_action :set_client_tank_interaction, only: [:show, :update, :destroy]

  # GET /client_tank_interactions
  def index
    @client_tank_interactions = ClientTankInteraction.all

    render json: @client_tank_interactions
  end

  # GET /client_tank_interactions/1
  def show
    render json: @client_tank_interaction
  end

  # POST /client_tank_interactions
  def create
    @client_tank_interaction = ClientTankInteraction.new(client_tank_interaction_params)

    if @client_tank_interaction.save
      render json: @client_tank_interaction, status: :created, location: @client_tank_interaction
    else
      render json: @client_tank_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_tank_interactions/1
  def update
    if @client_tank_interaction.update(client_tank_interaction_params)
      render json: @client_tank_interaction
    else
      render json: @client_tank_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_tank_interactions/1
  def destroy
    @client_tank_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_tank_interaction
      @client_tank_interaction = ClientTankInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_tank_interaction_params
      params.require(:client_tank_interaction).permit(:client_id, :tank_id)
    end
end
