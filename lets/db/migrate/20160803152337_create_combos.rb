class CreateCombos < ActiveRecord::Migration[5.0]
  def change
    create_table :combos do |t|
      t.string :name
      t.string :description
      t.datetime :buyable_from
      t.datetime :buyable_until
      t.integer :min_age
      t.integer :max_age
      t.integer :gender
      t.integer :stock
      t.integer :admission_level

      t.timestamps
    end
  end
end
