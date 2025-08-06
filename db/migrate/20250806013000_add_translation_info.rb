class AddTranslationInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :needs_translation, :boolean
    add_column :clients, :translation_language, :string
  end
end
