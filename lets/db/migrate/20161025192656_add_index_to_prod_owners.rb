class AddIndexToProdOwners < ActiveRecord::Migration[5.0]
  def change
  	add_index :prod_owners, [:account_id, :producer_id], unique: true
  end
end
