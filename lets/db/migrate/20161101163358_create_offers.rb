class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :price
      t.datetime :redeem_start
      t.datetime :redeem_finish
      t.references :combo, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
