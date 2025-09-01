class ClientMailboxesController < ApplicationController
  before_action :set_client_mailbox, only: [:show, :update, :destroy]

  # GET /client_mailboxes
  def index
    @client_mailboxes = ClientMailbox.all

    render json: @client_mailboxes
  end

  # GET /client_mailboxes/1
  def show
    render json: @client_mailbox
  end

  # POST /client_mailboxes
  def create
    @client_mailbox = ClientMailbox.new(client_mailbox_params)

    if @client_mailbox.save
      render json: @client_mailbox, status: :created, location: @client_mailbox
    else
      render json: @client_mailbox.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_mailboxes/1
  def update
    if @client_mailbox.update(client_mailbox_params)
      render json: @client_mailbox
    else
      render json: @client_mailbox.errors, status: :unprocessable_entity
    end
  end
  
  # GET /getMailboxForClient?clientId={id}
  def getMailboxForClient
    client = Client.find_by(id: params[:clientId])
  
    if client&.client_mailbox
      render json: client.client_mailbox
    else
      render json: { error: 'Mailbox not found for client' }, status: :not_found
    end
  end

  # DELETE /client_mailboxes/1
  def destroy
    @client_mailbox.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_mailbox
      @client_mailbox = ClientMailbox.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_mailbox_params
      params.require(:client_mailbox).permit(:client_id, :mailbox_number, :verification_type)
    end
end
