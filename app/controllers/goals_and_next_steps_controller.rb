class GoalsAndNextStepsController < ApplicationController
  before_action :set_goals_and_next_step, only: [:show, :update, :destroy]

  # GET /goals_and_next_steps
  def index
    @goals_and_next_steps = GoalsAndNextStep.all

    render json: @goals_and_next_steps
  end

  # GET /goals_and_next_steps/1
  def show
    render json: @goals_and_next_step
  end

  # POST /goals_and_next_steps
  def create
    @goals_and_next_step = GoalsAndNextStep.new(goals_and_next_step_params)

    if @goals_and_next_step.save
      render json: @goals_and_next_step, status: :created, location: @goals_and_next_step
    else
      render json: @goals_and_next_step.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals_and_next_steps/1
  def update
    if @goals_and_next_step.update(goals_and_next_step_params)
      render json: @goals_and_next_step
    else
      render json: @goals_and_next_step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /goals_and_next_steps/1
  def destroy
    @goals_and_next_step.destroy
  end
  
  # GET /locationsForRoute?routeId={id}
  def goalsForClient
    @goals = GoalsAndNextStep.where(:client_id => params[:clientId]) #maybe Location.where('route_id = ?', params[:routeId])
    
    render json: @goals
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goals_and_next_step
      @goals_and_next_step = GoalsAndNextStep.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def goals_and_next_step_params
      params.require(:goals_and_next_step).permit(:client_id, :description, :is_completed)
    end
end
