class AddBuyerToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_reference :purchases, :buyer, references: :users, index: true
		add_foreign_key :purchases, :users, column: :buyer_id
  end
end
