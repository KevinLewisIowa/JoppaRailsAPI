class AddIsCompletedToPrayerRequestAndNeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :prayer_request_and_needs, :is_completed, :boolean
  end
end
