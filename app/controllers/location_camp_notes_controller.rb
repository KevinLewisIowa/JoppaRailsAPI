class LocationCampNotesController < ApplicationController
  before_action :set_location_camp_note, only: [:show, :update, :destroy]

  # GET /location_camp_notes
  def index
    @location_camp_notes = LocationCampNote.all

    render json: @location_camp_notes
  end

  # GET /location_camp_notes/1
  def show
    render json: @location_camp_note
  end

  # POST /location_camp_notes
  def create
    @location_camp_note = LocationCampNote.new(location_camp_note_params)

    if @location_camp_note.save
      render json: @location_camp_note, status: :created, location: @location_camp_note
    else
      render json: @location_camp_note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /location_camp_notes/1
  def update
    if @location_camp_note.update(location_camp_note_params)
      render json: @location_camp_note
    else
      render json: @location_camp_note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /location_camp_notes/1
  def destroy
    @location_camp_note.destroy
  end
  
  # GET /getCampNotes?location_camp_id={id}
  def getCampNotes
    apiToken = request.headers['Authorization']
    passwordAndToken = PassToken.find(1)
    if passwordAndToken.api_token != apiToken
      return render json: {message: 'invalid-token'}
    end
    @campnotes = LocationCampNote.where('location_camp_id = ?', params[:locationCampId]);
    
    render json: @campnotes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_camp_note
      @location_camp_note = LocationCampNote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_camp_note_params
      params.require(:location_camp_note).permit(:location_camp_id, :note)
    end
end
