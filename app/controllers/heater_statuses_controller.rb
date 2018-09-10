class HeaterStatusesController < ApplicationController
  before_action :set_heater_status, only: [:show, :update, :destroy]

  # GET /heater_statuses
  def index
    @heater_statuses = HeaterStatus.all

    render json: @heater_statuses
  end

  # GET /heater_statuses/1
  def show
    render json: @heater_status
  end

  # POST /heater_statuses
  def create
    @heater_status = HeaterStatus.new(heater_status_params)

    if @heater_status.save
      render json: @heater_status, status: :created, location: @heater_status
    else
      render json: @heater_status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heater_statuses/1
  def update
    if @heater_status.update(heater_status_params)
      render json: @heater_status
    else
      render json: @heater_status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heater_statuses/1
  def destroy
    @heater_status.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heater_status
      @heater_status = HeaterStatus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def heater_status_params
      params.require(:heater_status).permit(:status_name)
    end
end
