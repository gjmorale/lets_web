class CreateProdOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :prod_owners do |t|
      t.references :account, foreign_key: true
      t.references :producer, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
