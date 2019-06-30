class ClientPetsController < ApplicationController
  before_action :set_client_pet, only: [:show, :update, :destroy]

  # GET /client_pets
  def index
    @client_pets = ClientPet.all

    render json: @client_pets
  end

  # GET /client_pets/1
  def show
    render json: @client_pet
  end

  # POST /client_pets
  def create
    @client_pet = ClientPet.new(client_pet_params)

    if @client_pet.save
      render json: @client_pet, status: :created, location: @client_pet
    else
      render json: @client_pet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_pets/1
  def update
    if @client_pet.update(client_pet_params)
      render json: @client_pet
    else
      render json: @client_pet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_pets/1
  def destroy
    @client_pet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_pet
      @client_pet = ClientPet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_pet_params
      params.require(:client_pet).permit(:client_id, :pet_type, :quantity, :food_requested)
    end
end
