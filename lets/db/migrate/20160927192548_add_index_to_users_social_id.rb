class AddIndexToUsersSocialId < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, :social_id, unique: true
  end
end
