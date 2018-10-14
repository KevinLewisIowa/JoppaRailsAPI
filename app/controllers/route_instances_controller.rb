class RouteInstancesController < ApplicationController
  before_action :set_route_instance, only: [:show, :update, :destroy]

  # GET /route_instances
  def index
    @route_instances = RouteInstance.all

    render json: @route_instances
  end

  # GET /route_instances/1
  def show
    render json: @route_instance
  end

  # POST /route_instances
  def create
    @route_instance = RouteInstance.new(route_instance_params)

    if @route_instance.save
      render json: @route_instance, status: :created, location: @route_instance
    else
      render json: @route_instance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /route_instances/1
  def update
    if @route_instance.update(route_instance_params)
      render json: @route_instance
    else
      render json: @route_instance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /route_instances/1
  def destroy
    @route_instance.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route_instance
      @route_instance = RouteInstance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_instance_params
      params.require(:route_instance).permit(:route_id, :leader_name, :leader_phone, :number_route_members, :heat_route, :start_time, :end_time)
    end
end
