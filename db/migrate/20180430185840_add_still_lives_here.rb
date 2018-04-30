class AddStillLivesHere < ActiveRecord::Migration[5.0]
  def change
    add_column :client_interactions, :still_lives_here, :boolean
    add_column :client_interactions, :was_seen, :boolean
  end
end
