class AddClientIdToFriends < ActiveRecord::Migration[6.1]
  def change
    add_column :client_circle_of_friends, :client_id, :integer
  end
end
