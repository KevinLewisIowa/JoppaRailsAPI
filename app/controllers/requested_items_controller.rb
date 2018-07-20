class RequestedItemsController < ApplicationController
  before_action :set_requested_item, only: [:show, :update, :destroy]

  # GET /requested_items
  def index
    @requested_items = RequestedItem.all

    render json: @requested_items
  end

  # GET /requested_items/1
  def show
    render json: @requested_item
  end

  # POST /requested_items
  def create
    @requested_item = RequestedItem.new(requested_item_params)

    if @requested_item.save
      render json: @requested_item, status: :created, location: @requested_item
    else
      render json: @requested_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /requested_items/1
  def update
    if @requested_item.update(requested_item_params)
      render json: @requested_item
    else
      render json: @requested_item.errors, status: :unprocessable_entity
    end
  end
  
  #receivedRequestedItem/?requestId=[number]
  def receivedRequestedItem
    @item = RequestedItem.find(params[:requestId])
    @item.has_received = true
    @item.save
  end

  # DELETE /requested_items/1
  def destroy
    @requested_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requested_item
      @requested_item = RequestedItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def requested_item_params
      params.require(:requested_item).permit(:client_id, :item_description, :date_requested, :has_received)
    end
end
