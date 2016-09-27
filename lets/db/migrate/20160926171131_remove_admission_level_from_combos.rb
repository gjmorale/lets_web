class RemoveAdmissionLevelFromCombos < ActiveRecord::Migration[5.0]
  def change
    remove_column :combos, :admission_level, :integer
  end
end
