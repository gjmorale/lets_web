class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.datetime :date
      t.string :qr
      t.integer :price_paid
      t.integer :status
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
