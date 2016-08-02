class CreateClubs < ActiveRecord::Migration[5.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :address
      t.integer :capacity

      t.timestamps
    end
  end
end
