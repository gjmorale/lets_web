class CreateTableAccountsProducers < ActiveRecord::Migration[5.0]
  def change
    create_table :table_accounts_producers do |t|
      t.string :account
      t.string :producer
    end
  end
end
