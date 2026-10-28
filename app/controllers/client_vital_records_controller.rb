class ClientVitalRecordsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_client_vital_record, only: [:update, :retrieve]

  def create
    record_params = client_vital_record_params
    client = Client.find(record_params.delete(:client_id))
    @client_vital_record = client.client_vital_records.new(record_params)

    if @client_vital_record.save
      render json: @client_vital_record, status: :created
    else
      render json: @client_vital_record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client_vital_record.update(client_vital_record_params.except(:client_id))
      render json: @client_vital_record
    else
      render json: @client_vital_record.errors, status: :unprocessable_entity
    end
  end

  def getClientVitalRecords
    records = Client.find(params[:clientId]).client_vital_records.order(:entered_on, :id)
    render json: records
  end

  def retrieve
    @client_vital_record.update(retrieved_on: Date.current) if @client_vital_record.retrieved_on.nil?
    render json: @client_vital_record
  end

  private

  def set_client_vital_record
    @client_vital_record = ClientVitalRecord.find(params[:id])
  end

  def client_vital_record_params
    params.require(:client_vital_record).permit(
      :client_id,
      :document_type,
      :notes,
      :entered_on,
      :signed_agreement
    )
  end
end