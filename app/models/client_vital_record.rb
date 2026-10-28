class ClientVitalRecord < ApplicationRecord
  DOCUMENT_TYPES = [
    "Birth certificate",
    "Copy of birth certificate",
    "Copy of driver's license",
    "Copy of ID",
    "Copy of social security card",
    "Drivers license",
    "ID",
    "Medical record",
    "Legal document",
    "Social security card",
    "Photo(s)",
    "Other"
  ].freeze

  belongs_to :client

  validates :document_type, inclusion: { in: DOCUMENT_TYPES }
  validates :entered_on, presence: true
end