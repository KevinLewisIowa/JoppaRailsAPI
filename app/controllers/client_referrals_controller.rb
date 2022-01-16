class ClientReferralsController < ApplicationController
  before_action :set_client_referral, only: [:show, :update, :destroy]

  # GET /client_referrals
  def index
    @client_referrals = ClientReferral.all

    render json: @client_referrals
  end

  # GET /client_referrals/1
  def show
    render json: @client_referral
  end

  # POST /client_referrals
  def create
    @client_referral = ClientReferral.new(client_referral_params)

    if @client_referral.save
      render json: @client_referral, status: :created, location: @client_referral
    else
      render json: @client_referral.errors, status: :unprocessable_entity
    end
  end
  
  # GET /client_referrals_report?fromDate={fromDate}&toDate={toDate}
  def client_referrals_report
    @client_referrals_report = ClientReferral.joins('LEFT JOIN clients c ON client_referrals.client_id').where('client_referrals.created_at BETWEEN ? AND ?', params[:fromDate], Date.parse(params[:toDate]).next_day(1)).select('client_referrals.client_id, c.first_name, c.preferred_name, c.last_name, client_referrals.created_at, client_referrals.referral_type, client_referrals.quantity, client_referrals.notes,').order('client_referrals.created_at')
    
    render json: @seen_and_serviced_report
  end

  # PATCH/PUT /client_referrals/1
  def update
    if @client_referral.update(client_referral_params)
      render json: @client_referral
    else
      render json: @client_referral.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_referrals/1
  def destroy
    @client_referral.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_referral
      @client_referral = ClientReferral.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_referral_params
      params.require(:client_referral).permit(:referral_type, :quantity, :notes, :client_id)
    end
end
