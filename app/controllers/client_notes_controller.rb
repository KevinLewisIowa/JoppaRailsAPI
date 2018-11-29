class ClientNotesController < ApplicationController
  before_action :set_client_note, only: [:show, :update, :destroy]

  # GET /client_notes
  def index
    @client_notes = ClientNote.all

    render json: @client_notes
  end

  # GET /client_notes/1
  def show
    render json: @client_note
  end
  
  # GET /getClientNotesForRoute?clientId={client_id}&routeInstanceId={route_instance_id}
  def getClientNotesForRoute
    @client_notes_on_route = ClientNote.where('client_id = ? AND route_instance_id = ?', params[:clientId], params[:routeInstanceId])
    
    render json: @client_notes_on_route
  end
  
  # GET /getNotesForRouteInstance?routeInstance={route_instance_id}
  def getNotesForRouteInstance
    @notes_for_route_instance = ClientNote.where('route_instance_id = ?', params[:routeInstanceId])
    
    render json: @notes_for_route_instance
  end

  # POST /client_notes
  def create
    @client_note = ClientNote.new(client_note_params)

    if @client_note.save
      render json: @client_note, status: :created, location: @client_note
    else
      render json: @client_note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_notes/1
  def update
    if @client_note.update(client_note_params)
      render json: @client_note
    else
      render json: @client_note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_notes/1
  def destroy
    @client_note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_note
      @client_note = ClientNote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_note_params
      params.require(:client_note).permit(:route_instance_id, :client_id, :note)
    end
end
