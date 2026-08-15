class AdminLoginsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_admin, only: [:create]

  # POST /admin_login
  def create
    if @admin && @admin.authenticate(params[:password])
      token = AdminToken.generate_for_admin(@admin)
      expires_at = 7.days.from_now

      AdminToken.create!(
        admin_id: @admin.id,
        token: token,
        expires_at: expires_at
      )

      @admin.update(
        last_login_at: Time.current,
        last_login_ip: request.remote_ip
      )

      AdminAuditLog.create(
        admin_id: @admin.id,
        action: :login_success,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )

      render json: {
        token: token,
        expires_at: expires_at,
        admin_id: @admin.id,
        email: @admin.email,
        role: @admin.role,
        requires_password_change: @admin.requires_password_change
      }, status: :ok
    else
      AdminAuditLog.create(
        admin_id: @admin&.id,
        action: :login_failed,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      ) if @admin

      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def set_admin
    @admin = Admin.active.find_by(email: params[:email].downcase) if params[:email].present?
  end
end
