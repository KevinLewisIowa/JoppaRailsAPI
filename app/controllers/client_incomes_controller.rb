class ClientIncomesController < ApplicationController
  before_action :set_client_income, only: [:show, :update, :destroy]

  # GET /client_incomes
  def index
    @client_incomes = ClientIncome.all

    render json: @client_incomes
  end

  # GET /client_incomes/1
  def show
    render json: @client_income
  end

  # POST /client_incomes
  def create
    @client_income = ClientIncome.new(client_income_params)

    if @client_income.save
      render json: @client_income, status: :created, location: @client_income
    else
      render json: @client_income.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_incomes/1
  def update
    if @client_income.update(client_income_params)
      render json: @client_income
    else
      render json: @client_income.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_incomes/1
  def destroy
    @client_income.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_income
      @client_income = ClientIncome.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_income_params
      params.require(:client_income).permit(:client_id, :has_income, :monthly_money, :what_income_from)
    end
end
