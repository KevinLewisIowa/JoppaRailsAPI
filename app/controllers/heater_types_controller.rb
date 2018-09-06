class HeaterTypesController < ApplicationController
  before_action :set_heater_type, only: [:show, :update, :destroy]

  # GET /heater_types
  def index
    @heater_types = HeaterType.all

    render json: @heater_types
  end

  # GET /heater_types/1
  def show
    render json: @heater_type
  end

  # POST /heater_types
  def create
    @heater_type = HeaterType.new(heater_type_params)

    if @heater_type.save
      render json: @heater_type, status: :created, location: @heater_type
    else
      render json: @heater_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heater_types/1
  def update
    if @heater_type.update(heater_type_params)
      render json: @heater_type
    else
      render json: @heater_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heater_types/1
  def destroy
    @heater_type.destroy
  end
  
  def getHeaterTypes
    @heater_type_dropdown = HeaterType.select("id", "type_description")
    
    render json: @heater_type_dropdown
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heater_type
      @heater_type = HeaterType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def heater_type_params
      params.require(:heater_type).permit(:type_description)
    end
end
