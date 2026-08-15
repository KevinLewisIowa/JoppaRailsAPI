class ClientNotesController < ApplicationController
  before_action :set_client_note, only: [:show, :update, :destroy]

  # GET /client_notes
  def index
    @client_notes = filtered_client_notes

    render json: @client_notes
  end

  # GET /getClientNotesByDateRange?startDate=...&endDate=...&clientId=...
  def getClientNotesByDateRange
    @client_notes = filtered_client_notes

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
  
  # GET /hasPinnedOrWarningNote?clientId={client_id}
  def hasPinnedOrWarningNote
    has_note = ClientNote.where(client_id: params[:clientId])
                         .where(source: ['PINNED NOTE', 'WARNING', 'RESOURCE CENTER ALERT'])
                         .exists?

    render json: { hasPinnedOrWarningNote: has_note }
  end
  
  # GET /getClientNotesForRoute?clientId={client_id}
  def getClientNotesForClient
    @client_notes_on_client = ClientNote.where('client_id = ?', params[:clientId])
    
    render json: @client_notes_on_client
  end
  
  # GET /getNotesForRouteInstance?routeInstance={route_instance_id}
  def getNotesForRouteInstance
    @notes_for_route_instance = ClientNote.joins(:client).where('route_instance_id = ?', params[:routeInstanceId]).select('clients.first_name, clients.preferred_name, clients.last_name, client_notes.note')
    
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

    def filtered_client_notes
      relation = ClientNote.all

      start_date = parse_date_param(params[:startDate] || params[:start_date])
      end_date = parse_date_param(params[:endDate] || params[:end_date])

      if start_date && end_date && start_date > end_date
        return relation.none
      end

      relation = relation.where('created_at >= ?', start_date.beginning_of_day) if start_date
      relation = relation.where('created_at <= ?', end_date.end_of_day) if end_date

      client_id_filter = params[:clientId] || params[:client_id]
      unless client_id_filter.blank? || client_id_filter.to_s.casecmp('AllClients').zero?
        relation = relation.where(client_id: client_id_filter)
      end

      relation.order(created_at: :desc)
    end

    def parse_date_param(value)
      return if value.blank?

      Time.zone.parse(value.to_s)
    rescue ArgumentError
      nil
    end

    # Only allow a trusted parameter "white list" through.
    def client_note_params
      params.require(:client_note).permit(:route_instance_id, :client_id, :note, :source)
    end
end
