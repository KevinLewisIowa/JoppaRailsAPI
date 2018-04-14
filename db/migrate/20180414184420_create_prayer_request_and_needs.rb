class CreatePrayerRequestAndNeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :prayer_request_and_needs do |t|
      t.integer :client_id
      t.string :detail

      t.timestamps
    end
  end
end
