class ClientDislikesController < ApplicationController
  before_action :set_client_dislike, only: [:show, :update, :destroy]

  # GET /client_dislikes
  def index
    @client_dislikes = ClientDislike.all

    render json: @client_dislikes
  end

  # GET /client_dislikes/1
  def show
    render json: @client_dislike
  end

  # POST /client_dislikes
  def create
    @client_dislike = ClientDislike.new(client_dislike_params)

    if @client_dislike.save
      render json: @client_dislike, status: :created, location: @client_dislike
    else
      render json: @client_dislike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_dislikes/1
  def update
    if @client_dislike.update(client_dislike_params)
      render json: @client_dislike
    else
      render json: @client_dislike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_dislikes/1
  def destroy
    @client_dislike.destroy
  end


# GET /dislikesForClient?clientId={id}
  def dislikesForClient
    @dislikes = ClientDislike.where(:client_id => params[:clientId]) #maybe Location.where('route_id = ?', params[:routeId])
    
    render json: @dislikes
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_dislike
      @client_dislike = ClientDislike.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_dislike_params
      params.require(:client_dislike).permit(:client_id, :description)
    end
end
