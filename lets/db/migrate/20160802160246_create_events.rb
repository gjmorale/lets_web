class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :capacity
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
