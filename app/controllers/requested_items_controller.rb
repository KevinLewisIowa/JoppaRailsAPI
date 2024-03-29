class RequestedItemsController < ApplicationController
  before_action :set_requested_item, only: [:show, :update, :destroy]

  # GET /requested_items
  def index
    items = []
    RequestedItem.find_each do |item|
      items.push(item)
    end
    @requested_items = items

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
  
  #GET /getClientHasFulfilledItems?clientId={client_id}
  def getClientHasFulfilledItems
    @items = RequestedItem.where('client_id = ? AND fulfilled = true AND has_received = false', params[:clientId]).count;
    
    render json: @items
  end
  
  #recentReceivedItems?clientId=[number]
  def recentReceivedItems
    @items = RequestedItem.where('client_id = ? AND has_received = ?', params[:clientId], true).order('updated_at desc').limit(10);
    
    render json: @items
  end
  
  #GET /getItemsByClientAndDate?clientId={client_id}&fromDate={from_Date}&toDate={to_date}
  def getItemsByClientAndDate
    @client_id = params[:clientId]
    @items = [];
    if @client_id == 'ALLCLIENTS'
      @items = RequestedItem.where('date_requested BETWEEN ? AND ?', params[:fromDate], Date.parse(params[:toDate]).next_day(1))
    else
      @items = RequestedItem.where('client_id = ? AND date_requested BETWEEN ? AND ?', params[:clientId], params[:fromDate], Date.parse(params[:toDate]).next_day(1))
    end
      
    render json: @items
  end
  
  #receivedRequestedItem/?requestId=[number]
  def receivedRequestedItem
    @item = RequestedItem.find(params[:requestId])
    @item.has_received = true
    @item.save
    
    render json: @item
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
      params.require(:requested_item).permit(:client_id, :item_description, :date_requested, :has_received, :fulfilled)
    end
end
