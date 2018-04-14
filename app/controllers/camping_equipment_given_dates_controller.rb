class CampingEquipmentGivenDatesController < ApplicationController
  before_action :set_camping_equipment_given_date, only: [:show, :update, :destroy]

  # GET /camping_equipment_given_dates
  def index
    @camping_equipment_given_dates = CampingEquipmentGivenDate.all

    render json: @camping_equipment_given_dates
  end

  # GET /camping_equipment_given_dates/1
  def show
    render json: @camping_equipment_given_date
  end

  # POST /camping_equipment_given_dates
  def create
    @camping_equipment_given_date = CampingEquipmentGivenDate.new(camping_equipment_given_date_params)

    if @camping_equipment_given_date.save
      render json: @camping_equipment_given_date, status: :created, location: @camping_equipment_given_date
    else
      render json: @camping_equipment_given_date.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /camping_equipment_given_dates/1
  def update
    if @camping_equipment_given_date.update(camping_equipment_given_date_params)
      render json: @camping_equipment_given_date
    else
      render json: @camping_equipment_given_date.errors, status: :unprocessable_entity
    end
  end

  # DELETE /camping_equipment_given_dates/1
  def destroy
    @camping_equipment_given_date.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camping_equipment_given_date
      @camping_equipment_given_date = CampingEquipmentGivenDate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def camping_equipment_given_date_params
      params.require(:camping_equipment_given_date).permit(:client_id, :camping_equipment_id, :date_given, :has_returned)
    end
end
