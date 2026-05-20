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

  # GET /getRoutePetCounts?routeId={route_id}
  def getRoutePetCounts
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: { message: 'invalid-token' }
    end

    route_pets = ClientPet.joins(client: :location_camp)
                          .where('location_camps.route_id = ? AND clients.status = ? AND location_camps.is_active = ?', params[:routeId], 'Active', true)

    totals = route_pets.group(:pet_type).sum(:quantity)
    totals = totals.transform_keys { |pet_type| normalize_pet_type_key(pet_type) }

    per_camp = {}
    route_pets
      .select('location_camps.id AS camp_id, client_pets.pet_type, SUM(COALESCE(client_pets.quantity, 1)) AS total_quantity')
      .group('location_camps.id, client_pets.pet_type')
      .find_each do |record|
        camp_id = record.camp_id
        pet_key = normalize_pet_type_key(record.pet_type)
        per_camp[camp_id] ||= {}
        per_camp[camp_id][pet_key] = record.total_quantity.to_i
      end

    render json: {
      totals: totals,
      per_camp: per_camp
    }
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_client_pet
      @client_pet = ClientPet.find(params[:id])
    end

    def normalize_pet_type_key(pet_type)
      return 'unknown' if pet_type.blank?
      pet_type.to_s.strip.downcase.pluralize
    end

    def client_pet_params
      params.require(:client_pet).permit(:client_id, :pet_type, :food_requested, :age, :pet_name, :breed, :quantity)
    end
end
