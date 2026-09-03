class Admin < ApplicationRecord
  has_secure_password
  has_many :admin_audit_logs, dependent: :destroy

  enum role: { admin: 0, super_admin: 1 }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true, on: :create
  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?
  validates :password, format: {
    with: /\A(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+=\-\[\]{};':"\\|,.<>\/?])[A-Za-z\d !@#$%^&*()_+=\-\[\]{};':"\\|,.<>\/?]{8,}\z/,
    message: "must contain at least one uppercase letter, one number, and one special character"
  }, if: :password_required?

  before_create :set_active_true
  before_create :set_requires_password_change_true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def password_required?
    password.present? || password_confirmation.present?
  end

  def set_active_true
    self.active = true if active.nil?
  end

  def set_requires_password_change_true
    self.requires_password_change = true if requires_password_change.nil?
  end

  def generate_token
    loop do
      token = SecureRandom.random_bytes(6).unpack1('H*')
      break token unless AdminToken.exists?(token: token)
    end
  end

  def generate_temp_password
    require 'securerandom'
    # Generate a 12-character password with uppercase, lowercase, number, and special char.
    chars_lower = ('a'..'z').to_a
    chars_upper = ('A'..'Z').to_a
    chars_digit = ('0'..'9').to_a
    chars_special = ['!', '@', '#', '$', '%', '^', '&', '*']

    base62 = chars_lower + chars_upper + chars_digit
    
    password = [
      chars_upper.sample,
      chars_digit.sample,
      chars_special.sample,
      *Array.new(9) { base62[SecureRandom.random_number(base62.length)] }
    ].shuffle.join
    
    password
  end
end
