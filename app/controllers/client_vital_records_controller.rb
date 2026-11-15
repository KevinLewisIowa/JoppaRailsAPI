class ClientVitalRecordsController < ApplicationController
  MAX_PAGE_SIZE = 500
  DEFAULT_PAGE_SIZE = 100

  before_action :authorize_admin!, only: [:create, :update, :retrieve, :getClientVitalRecordsByDate]
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

  def getClientVitalRecordsByDate
    from_date = parse_iso_date(params[:fromDate])
    to_date = parse_iso_date(params[:toDate])
    unless from_date && to_date
      return render json: { message: "fromDate and toDate must be valid dates in YYYY-MM-DD format" },
                    status: :unprocessable_entity
    end
    if from_date > to_date
      return render json: { message: "fromDate must be on or before toDate" },
                    status: :unprocessable_entity
    end

    page_size = params.key?(:pageSize) ? parse_positive_integer(params[:pageSize]) : DEFAULT_PAGE_SIZE
    unless page_size && page_size <= MAX_PAGE_SIZE
      return render json: { message: "pageSize must be between 1 and #{MAX_PAGE_SIZE}" },
                    status: :unprocessable_entity
    end

    cursor_supplied = params.key?(:afterEnteredOn) || params.key?(:afterId)
    if cursor_supplied
      cursor_date = parse_iso_date(params[:afterEnteredOn])
      cursor_id = parse_positive_integer(params[:afterId])
      unless cursor_date && cursor_id && cursor_id > 0 &&
             cursor_date >= from_date && cursor_date <= to_date
        return render json: { message: "afterEnteredOn and afterId must form a valid cursor within the date range" },
                      status: :unprocessable_entity
      end
    end

    records = ClientVitalRecord.where(entered_on: from_date..to_date)
                               .order(:entered_on, :id)
    if cursor_supplied
      records = records.where(
        "entered_on > :entered_on OR (entered_on = :entered_on AND id > :id)",
        entered_on: cursor_date,
        id: cursor_id
      )
    end

    page = records.limit(page_size + 1).to_a
    has_more = page.length > page_size
    page = page.first(page_size)
    next_cursor = if has_more
                    { afterEnteredOn: page.last.entered_on, afterId: page.last.id }
                  end

    render json: { records: page, nextCursor: next_cursor }
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

  def parse_iso_date(value)
    return unless value.is_a?(String) && value.match?(/\A\d{4}-\d{2}-\d{2}\z/)

    Date.iso8601(value)
  rescue Date::Error
    nil
  end

  def parse_positive_integer(value)
    return unless value.is_a?(String) && value.match?(/\A\d+\z/)

    parsed_value = Integer(value, 10)
    parsed_value if parsed_value > 0
  rescue ArgumentError
    nil
  end
end