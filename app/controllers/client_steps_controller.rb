class ClientStepsController < ApplicationController
  before_action :set_client_step, only: [:show, :update, :destroy]

  # GET /client_steps
  def index
    @client_steps = ClientStep.all

    render json: @client_steps
  end

  # GET /client_steps/1
  def show
    render json: @client_step
  end

  # POST /client_steps
  def create
    @client_step = ClientStep.new(client_step_params)

    if @client_step.save
      render json: @client_step, status: :created, location: @client_step
    else
      render json: @client_step.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_steps/1
  def update
    if @client_step.update(client_step_params)
      render json: @client_step
    else
      render json: @client_step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_steps/1
  def destroy
    @client_step.destroy
  end
  
  # GET getClientSteps?clientId={cid}
  def getClientSteps
    @steps = ClientStep.where(:client_id => params[:clientId])
    
    render json: @steps
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_step
      @client_step = ClientStep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_step_params
      params.require(:client_step).permit(:client_id, :step_type, :date_completed, :notes)
    end
end
