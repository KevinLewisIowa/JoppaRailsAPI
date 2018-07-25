class ChangeCamelCaseAttributes < ActiveRecord::Migration[5.0]
  def change
    rename_column :clients, :preferredName, :preferred_name
    rename_column :clients, :isVeteran, :is_veteran
    rename_column :clients, :birthDate, :birth_date
    rename_column :clients, :isAfterCare, :is_aftercare
    rename_column :clients, :shoeSize, :shoe_size
    rename_column :clients, :joppaApartmentNumber, :joppa_apartment_number
  end
end
