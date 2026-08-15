class AdminAuditLog < ApplicationRecord
  belongs_to :admin

  enum action: { login_success: 0, login_failed: 1, password_changed: 2, admin_created: 3, admin_reset_password: 4 }

  validates :admin_id, :action, :ip_address, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :by_admin, ->(admin_id) { where(admin_id: admin_id) }
  scope :by_action, ->(action) { where(action: action) }
end
