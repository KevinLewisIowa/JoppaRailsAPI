require 'test_helper'

class ClientDisabilityAndDisorderTest < ActiveSupport::TestCase
  test 'requires a valid category' do
    record = ClientDisabilityAndDisorder.new(client_id: 1, category: 'invalid', diagnosis_status: 'Yes')

    assert_not record.valid?
    assert_includes record.errors[:category], 'is not included in the list'
  end

  test 'accepts a valid physical disability record' do
    record = ClientDisabilityAndDisorder.new(
      client_id: 1,
      category: 'physical_disability',
      diagnosis_status: 'Yes',
      type_name: 'Arthritis',
      year_diagnosed: 2020,
      note: 'Chronic pain'
    )

    assert record.valid?
  end
end
