class ClientRentDetail < ApplicationRecord
  belongs_to :client

  validates :client_id, uniqueness: true
  validates :rent_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :utilities_included, inclusion: { in: [true, false] }
  validates :who_is_paying, presence: true, inclusion: { in: ["Self", "Other Organization", "Family Member", "Other"] }
  validate :validate_utilities_cost

  private

  def validate_utilities_cost
    if utilities_included?
      errors.add(:utilities_cost, "must be blank when utilities are included") if utilities_cost.present?
    elsif utilities_cost.blank?
      errors.add(:utilities_cost, "must be provided when utilities are not included")
    elsif utilities_cost.negative?
      errors.add(:utilities_cost, "must be greater than or equal to 0")
    end
  end
end
