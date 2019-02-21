class ClientLikesController < ApplicationController
  before_action :set_client_like, only: [:show, :update, :destroy]

  # GET /client_likes
  def index
    @client_likes = ClientLike.all

    render json: @client_likes
  end

  # GET /client_likes/1
  def show
    render json: @client_like
  end

  # POST /client_likes
  def create
    @client_like = ClientLike.new(client_like_params)

    if @client_like.save
      render json: @client_like, status: :created, location: @client_like
    else
      render json: @client_like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_likes/1
  def update
    if @client_like.update(client_like_params)
      render json: @client_like
    else
      render json: @client_like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_likes/1
  def destroy
    @client_like.destroy
  end
  
  # GET /locationsForRoute?routeId={id}
  def likesForClient
    @likes = ClientLike.where(:client_id => params[:clientId]) #maybe LocationCamp.where('route_id = ?', params[:routeId])
    
    render json: @likes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_like
      @client_like = ClientLike.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_like_params
      params.require(:client_like).permit(:client_id, :description)
    end
end
