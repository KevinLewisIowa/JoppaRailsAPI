class ClientDebtsController < ApplicationController
  before_action :set_client_debt, only: [:show, :update, :destroy]

  # GET /client_debts
  def index
    @client_debts = ClientDebt.all

    render json: @client_debts
  end

  # GET /client_debts/1
  def show
    render json: @client_debt
  end

  # POST /client_debts
  def create
    @client_debt = ClientDebt.new(client_debt_params)

    if @client_debt.save
      render json: @client_debt, status: :created, location: @client_debt
    else
      render json: @client_debt.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_debts/1
  def update
    if @client_debt.update(client_debt_params)
      render json: @client_debt
    else
      render json: @client_debt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_debts/1
  def destroy
    @client_debt.destroy
  end
  
  # GET getClientDebt?clientId={cid}
  def getClientDebt
    @debt = ClientDebt.where(:client_id => params[:clientId])
    
    render json: @debt
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_debt
      @client_debt = ClientDebt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_debt_params
      params.require(:client_debt).permit(:client_id, :debt_type, :amount, :notes)
    end
end
