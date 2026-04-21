class AddNotesToReleaseOfInformation < ActiveRecord::Migration[6.1]
  def change
    add_column :client_release_acknowledgements, :notes, :text
  end
end
