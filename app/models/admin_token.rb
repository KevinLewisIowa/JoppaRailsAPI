class AdminToken < ApplicationRecord
  belongs_to :admin

  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true

  scope :active, -> { where("expires_at > ?", Time.current) }
  scope :expired, -> { where("expires_at <= ?", Time.current) }

  def self.generate_for_admin(admin)
    loop do
      token = SecureRandom.random_bytes(6).unpack1('H*')
      break token unless exists?(token: token)
    end
  end

  def expired?
    expires_at <= Time.current
  end

  def valid?(context = nil)
    super(context) && !expired?
  end
end
