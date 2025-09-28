class AuthorizedMailAccessesController < ApplicationController
  before_action :set_authorized_mail_access, only: [:show, :update, :destroy]

  # GET /authorized_mail_accesses
  def index
    @authorized_mail_accesses = AuthorizedMailAccess.all

    render json: @authorized_mail_accesses
  end

  # GET /authorized_mail_accesses/1
  def show
    render json: @authorized_mail_access
  end

  # POST /authorized_mail_accesses
  def create
    @authorized_mail_access = AuthorizedMailAccess.new(authorized_mail_access_params)

    if @authorized_mail_access.save
      render json: @authorized_mail_access, status: :created, location: @authorized_mail_access
    else
      render json: @authorized_mail_access.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authorized_mail_accesses/1
  def update
    if @authorized_mail_access.update(authorized_mail_access_params)
      render json: @authorized_mail_access
    else
      render json: @authorized_mail_access.errors, status: :unprocessable_entity
    end
  end
  
  # GET /getAuthorizedMailAccessors?mailboxId={id}
  def getAuthorizedMailAccessors
    mailbox_id = params[:mailboxId]
    # Now use mailbox_id in your logic, e.g.:
    @accessors = AuthorizedMailAccess.where(mailbox_id: mailbox_id)
    render json: @accessors
  end

  # DELETE /authorized_mail_accesses/1
  def destroy
    @authorized_mail_access.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorized_mail_access
      @authorized_mail_access = AuthorizedMailAccess.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def authorized_mail_access_params
      params.require(:authorized_mail_access).permit(:mailbox_id, :authorized_name, :relation_to_client, :date_authorized)
    end
end
