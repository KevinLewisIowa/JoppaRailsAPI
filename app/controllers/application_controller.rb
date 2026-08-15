class ApplicationController < ActionController::API
  attr_reader :current_admin

  before_action :authenticate_admin!, unless: :skip_admin_auth?

  protected

  def authenticate_admin!
    token = extract_token_from_header
    return render_unauthorized("No token provided") if token.blank?

    admin_token = AdminToken.find_by(token: token)
    return render_unauthorized("Invalid token") if admin_token.blank?

    if admin_token.expired?
      admin_token.destroy
      return render_unauthorized("Token expired", "token-expired")
    end

    @current_admin = admin_token.admin
    return render_unauthorized("Admin not found or inactive") unless @current_admin&.active?
  end

  def authorize_super_admin!
    return render_unauthorized("Only super admins can perform this action") unless current_admin&.super_admin?
  end

  def skip_admin_auth?
    action_name.in?(['create']) && controller_name == 'admin_logins'
  end

  private

  def extract_token_from_header
    header = request.headers['Authorization']
    return nil if header.blank?

    # Handle "Bearer token" or just "token"
    if header.start_with?('Bearer ')
      header.sub(/\ABearer /, '')
    else
      header
    end
  end

  def render_unauthorized(message, error_type = 'invalid-token')
    render json: { message: message, type: error_type }, status: :unauthorized
  end
end
