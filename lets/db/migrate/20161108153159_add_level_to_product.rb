class AddLevelToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :provided_level, references: :levels, index: true
		add_foreign_key :products, :levels, column: :provided_level_id
    add_reference :products, :required_level, references: :levels, index: true
		add_foreign_key :products, :levels, column: :required_level_id
  end
end
