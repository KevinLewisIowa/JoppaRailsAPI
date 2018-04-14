class CampingEquipmentsController < ApplicationController
  before_action :set_camping_equipment, only: [:show, :update, :destroy]

  # GET /camping_equipments
  def index
    @camping_equipments = CampingEquipment.all

    render json: @camping_equipments
  end

  # GET /camping_equipments/1
  def show
    render json: @camping_equipment
  end

  # POST /camping_equipments
  def create
    @camping_equipment = CampingEquipment.new(camping_equipment_params)

    if @camping_equipment.save
      render json: @camping_equipment, status: :created, location: @camping_equipment
    else
      render json: @camping_equipment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /camping_equipments/1
  def update
    if @camping_equipment.update(camping_equipment_params)
      render json: @camping_equipment
    else
      render json: @camping_equipment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /camping_equipments/1
  def destroy
    @camping_equipment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camping_equipment
      @camping_equipment = CampingEquipment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def camping_equipment_params
      params.require(:camping_equipment).permit(:name, :is_available, :joppa_number)
    end
end
