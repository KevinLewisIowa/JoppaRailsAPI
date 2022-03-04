class AddFulfilledToRequestedItems < ActiveRecord::Migration[6.1]
  def change
    add_column :requested_items, :fulfilled, :boolean
  end
end
