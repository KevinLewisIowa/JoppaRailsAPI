class PrayerRequestAndNeedsController < ApplicationController
  before_action :set_prayer_request_and_need, only: [:show, :update, :destroy]

  # GET /prayer_request_and_needs
  def index
    @prayer_request_and_needs = PrayerRequestAndNeed.all

    render json: @prayer_request_and_needs
  end

  # GET /prayer_request_and_needs/1
  def show
    render json: @prayer_request_and_need
  end

  # POST /prayer_request_and_needs
  def create
    @prayer_request_and_need = PrayerRequestAndNeed.new(prayer_request_and_need_params)

    if @prayer_request_and_need.save
      render json: @prayer_request_and_need, status: :created, location: @prayer_request_and_need
    else
      render json: @prayer_request_and_need.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prayer_request_and_needs/1
  def update
    if @prayer_request_and_need.update(prayer_request_and_need_params)
      render json: @prayer_request_and_need
    else
      render json: @prayer_request_and_need.errors, status: :unprocessable_entity
    end
  end

  # DELETE /prayer_request_and_needs/1
  def destroy
    @prayer_request_and_need.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prayer_request_and_need
      @prayer_request_and_need = PrayerRequestAndNeed.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prayer_request_and_need_params
      params.require(:prayer_request_and_need).permit(:client_id, :detail)
    end
end
