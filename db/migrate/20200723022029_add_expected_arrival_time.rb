class AddExpectedArrivalTime < ActiveRecord::Migration[5.0]
  def change
    add_column :location_camps, :expected_arrival_time, :string
  end
end
