class AddSeparateCityStateBeforeHomeless < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :city_before_homelessness, :string
    add_column :clients, :state_before_homelessness, :string
  end
end
