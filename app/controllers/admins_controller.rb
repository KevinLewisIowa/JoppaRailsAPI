class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_super_admin!, except: [:show, :update_own_profile]
  before_action :set_admin, only: [:show, :update, :destroy, :reset_password]

  # GET /admins
  def index
    @admins = Admin.active.order(created_at: :desc)
    render json: @admins.map { |admin| admin_json(admin) }, status: :ok
  end

  # GET /admins/:id
  def show
    render json: admin_json(@admin), status: :ok
  end

  # GET /admin_profile
  def profile
    render json: admin_json(current_admin), status: :ok
  end

  # POST /admins
  def create
    temp_password = Admin.new.generate_temp_password
    
    @admin = Admin.new(admin_params)
    @admin.password = temp_password
    @admin.password_confirmation = temp_password
    @admin.requires_password_change = true

    if @admin.save
      AdminAuditLog.create(
        admin_id: current_admin.id,
        action: :admin_created,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )

      render json: {
        admin: admin_json(@admin),
        temp_password: temp_password,
        message: "Admin created successfully. Provide this temporary password to the admin."
      }, status: :created
    else
      render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /admins/:id
  def update
    if @admin.update(admin_update_params)
      render json: admin_json(@admin), status: :ok
    else
      render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /admins/:id
  def destroy
    if @admin.update(active: false)
      AdminAuditLog.create(
        admin_id: current_admin.id,
        action: :admin_created,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )
      
      render json: { message: "Admin deactivated successfully" }, status: :ok
    else
      render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /admins/:id/reset_password
  def reset_password
    temp_password = @admin.generate_temp_password
    @admin.password = temp_password
    @admin.password_confirmation = temp_password
    @admin.requires_password_change = true

    if @admin.save
      AdminAuditLog.create(
        admin_id: current_admin.id,
        action: :admin_reset_password,
        ip_address: request.remote_ip,
        user_agent: request.user_agent
      )

      render json: {
        admin: admin_json(@admin),
        temp_password: temp_password,
        message: "Password reset successfully. Provide this temporary password to the admin."
      }, status: :ok
    else
      render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /admin_profile/change_password
  def change_password
    if current_admin.authenticate(params[:current_password])
      if params[:new_password] == params[:confirm_password]
        current_admin.password = params[:new_password]
        current_admin.password_confirmation = params[:confirm_password]
        current_admin.requires_password_change = false

        if current_admin.save
          AdminAuditLog.create(
            admin_id: current_admin.id,
            action: :password_changed,
            ip_address: request.remote_ip,
            user_agent: request.user_agent
          )

          render json: { message: "Password changed successfully" }, status: :ok
        else
          render json: { errors: current_admin.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { message: "Passwords do not match" }, status: :unprocessable_entity
      end
    else
      render json: { message: "Current password is incorrect" }, status: :unauthorized
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:email, :first_name, :last_name, :role)
  end

  def admin_update_params
    params.require(:admin).permit(:first_name, :last_name).tap do |p|
      # Only super_admin can change role
      p[:role] = params[:admin][:role] if current_admin.super_admin?
    end
  end

  def admin_json(admin)
    {
      id: admin.id,
      email: admin.email,
      first_name: admin.first_name,
      last_name: admin.last_name,
      role: admin.role,
      requires_password_change: admin.requires_password_change,
      last_login_at: admin.last_login_at,
      active: admin.active,
      created_at: admin.created_at,
      updated_at: admin.updated_at
    }
  end
end
