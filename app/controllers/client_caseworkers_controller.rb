class ClientCaseworkersController < ApplicationController
  before_action :set_client_caseworker, only: [:show, :update, :destroy]

  # GET /client_caseworkers
  def index
    @client_caseworkers = ClientCaseworker.all

    render json: @client_caseworkers
  end

  # GET /client_caseworkers/1
  def show
    render json: @client_caseworker
  end

  # POST /client_caseworkers
  def create
    @client_caseworker = ClientCaseworker.new(client_caseworker_params)

    if @client_caseworker.save
      render json: @client_caseworker, status: :created, location: @client_caseworker
    else
      render json: @client_caseworker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_caseworkers/1
  def update
    if @client_caseworker.update(client_caseworker_params)
      render json: @client_caseworker
    else
      render json: @client_caseworker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_caseworkers/1
  def destroy
    @client_caseworker.destroy
  end
  
  # GET getClientCaseworkers?clientId={cid}
  def getClientCaseworkers
    @caseworkers = ClientCaseworker.where(:client_id => params[:clientId])
    
    render json: @caseworkers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_caseworker
      @client_caseworker = ClientCaseworker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_caseworker_params
      params.require(:client_caseworker).permit(:organization, :name, :phone, :email, :notes, :client_id)
    end
end
