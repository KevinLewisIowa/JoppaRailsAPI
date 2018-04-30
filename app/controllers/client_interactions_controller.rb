class ClientInteractionsController < ApplicationController
  before_action :set_client_interaction, only: [:show, :update, :destroy]

  # GET /client_interactions
  def index
    @client_interactions = ClientInteraction.all

    render json: @client_interactions
  end

  # GET /client_interactions/1
  def show
    render json: @client_interaction
  end

  # POST /client_interactions
  def create
    @client_interaction = ClientInteraction.new(client_interaction_params)

    if @client_interaction.save
      render json: @client_interaction, status: :created, location: @client_interaction
    else
      render json: @client_interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_interactions/1
  def update
    if @client_interaction.update(client_interaction_params)
      render json: @client_interaction
    else
      render json: @client_interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_interactions/1
  def destroy
    @client_interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_interaction
      @client_interaction = ClientInteraction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_interaction_params
      params.require(:client_interaction).permit(:client_id, :location_camp_id, :serviced)
    end
end
