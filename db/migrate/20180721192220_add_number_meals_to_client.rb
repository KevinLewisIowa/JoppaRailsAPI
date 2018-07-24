class AddNumberMealsToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :number_meals, :integer
  end
end
