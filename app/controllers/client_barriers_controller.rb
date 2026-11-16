class ClientBarriersController < ApplicationController
  MAX_PAGE_SIZE = 500
  DEFAULT_PAGE_SIZE = 100

  before_action :set_client_barrier, only: [:show, :update, :destroy]

  # GET /client_barriers
  def index
    @client_barriers = ClientBarrier.all

    render json: @client_barriers
  end

  # GET /client_barriers/1
  def show
    render json: @client_barrier
  end

  # POST /client_barriers
  def create
    @client_barrier = ClientBarrier.new(client_barrier_params)

    if @client_barrier.save
      render json: @client_barrier, status: :created, location: @client_barrier
    else
      render json: @client_barrier.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_barriers/1
  def update
    if @client_barrier.update(client_barrier_params)
      render json: @client_barrier
    else
      render json: @client_barrier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_barriers/1
  def destroy
    @client_barrier.destroy
  end
  
  # GET getClientBarriers?clientId={cid}
  def getClientBarriers
    @barriers = ClientBarrier.where(:client_id => params[:clientId])
    
    render json: @barriers
  end

  # GET getClientBarrierRecordsByDate?fromDate=YYYY-MM-DD&toDate=YYYY-MM-DD
  def getClientBarrierRecordsByDate
    get_client_barrier_records_by_date
  end

  private

    def get_client_barrier_records_by_date
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

      from_time = from_date.in_time_zone.beginning_of_day
      to_time = (to_date + 1).in_time_zone.beginning_of_day
      cursor_supplied = params.key?(:afterCreatedAt) || params.key?(:afterId)
      if cursor_supplied
        cursor_time = parse_iso_timestamp(params[:afterCreatedAt])
        cursor_id = parse_positive_integer(params[:afterId])
        unless cursor_time && cursor_id &&
               cursor_time >= from_time && cursor_time < to_time
          return render json: { message: "afterCreatedAt and afterId must form a valid cursor within the date range" },
                        status: :unprocessable_entity
        end
      end

      barriers = ClientBarrier.where(created_at: from_time...to_time).order(:created_at, :id)
      if cursor_supplied
        barriers = barriers.where(
          "created_at > :created_at OR (created_at = :created_at AND id > :id)",
          created_at: cursor_time,
          id: cursor_id
        )
      end

      page = barriers.limit(page_size + 1).to_a
      has_more = page.length > page_size
      page = page.first(page_size)
      next_cursor = if has_more
                      { afterCreatedAt: page.last.created_at.iso8601(6), afterId: page.last.id }
                    end

      render json: { records: page, nextCursor: next_cursor }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_client_barrier
      @client_barrier = ClientBarrier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_barrier_params
      params.require(:client_barrier).permit(:client_id, :barrier_type, :note)
    end

    def parse_iso_date(value)
      return unless value.is_a?(String) && value.match?(/\A\d{4}-\d{2}-\d{2}\z/)

      Date.iso8601(value)
    rescue Date::Error
      nil
    end

    def parse_iso_timestamp(value)
      return unless value.is_a?(String)

      Time.iso8601(value)
    rescue ArgumentError
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
