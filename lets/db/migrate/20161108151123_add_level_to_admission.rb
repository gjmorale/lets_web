class AddLevelToAdmission < ActiveRecord::Migration[5.0]
  def change
    add_reference :admissions, :actual_level, references: :levels, index: true
		add_foreign_key :admissions, :levels, column: :actual_level_id
    add_reference :admissions, :guest_level, references: :levels, index: true
		add_foreign_key :admissions, :levels, column: :guest_level_id
  end
end
