class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :min_age
      t.integer :grants_admission
      t.integer :admission_level

      t.timestamps
    end
  end
end
