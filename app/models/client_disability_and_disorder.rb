class ClientDisabilityAndDisorder < ApplicationRecord
  VALID_CATEGORIES = %w[
    physical_disability
    mental_disability
    substance_use_disorder
  ].freeze

  validates :client_id, presence: true
  validates :category, inclusion: { in: VALID_CATEGORIES }
  validates :diagnosis_status, inclusion: { in: ['Yes', 'No', 'Unknown', 'Preferred not to share', 'Preferred to not share'], allow_blank: true }
  validates :clinically_diagnosed, inclusion: { in: ['Yes', 'No', 'Unknown', 'Didn’t want to share', "Didn't want to share"], allow_blank: true }

  belongs_to :client, class_name: 'Client', optional: true
end
