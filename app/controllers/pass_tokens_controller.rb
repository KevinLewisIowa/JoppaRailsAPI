class PassTokensController < ApplicationController
  before_action :set_pass_token, only: [:show, :update, :destroy]

  # GET /pass_tokens
  def index
    @pass_tokens = PassToken.all

    render json: @pass_tokens
  end

  # GET /pass_tokens/1
  def show
    render json: { data: 'nice try' }#json: @pass_token
  end
  
  def attemptLogin
    @passwords = PassToken.find(1)
    
    attemptedPassword = params[:passWrd]
    render json: {data: @passwords, attempt: attemptedPassword }
    if (@passwords.admin_password == attemptedPassword)
      if (@passwords.updated_at.to_date != Date.current)
        newToken = ('a'..'z').to_a.shuffle[0,8].join
        @passwords.api_token = newToken
        @passwords.save
      end
      theToken = @passwords.api_token
      render json: { admin: true, token: theToken }
    end
    if (@passwords.regular_password == attemptedPassword)
      if (@passwords.updated_at.to_date != Date.current)
        newToken = ('a'..'z').to_a.shuffle[0,8].join
        @passwords.api_token = newToken
        @passwords.save
      end
      theToken = @passwords.api_token
      render json: {admin: false, token: theToken }
    end
    
    render json: { admin: false, token: 'failedLogin' }
  end

  # POST /pass_tokens
  def create
    @pass_token = PassToken.new(pass_token_params)

    if @pass_token.save
      render json: @pass_token, status: :created, location: @pass_token
    else
      render json: @pass_token.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pass_tokens/1
  def update
    if @pass_token.update(pass_token_params)
      render json: @pass_token
    else
      render json: @pass_token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pass_tokens/1
  def destroy
    #@pass_token.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pass_token
      @pass_token = PassToken.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pass_token_params
      params.require(:pass_token).permit(:admin_password, :string, :regular_password, :string, :api_token, :string)
    end
end
