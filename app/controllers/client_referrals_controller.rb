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
