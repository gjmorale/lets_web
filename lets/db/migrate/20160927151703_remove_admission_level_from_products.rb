class RemoveAdmissionLevelFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :admission_level, :integer
  end
end
