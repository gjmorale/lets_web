class AddIndexToAdmissions < ActiveRecord::Migration[5.0]
  def change
  	add_index :admissions, [:user_id, :event_id], unique: true
  end
end
