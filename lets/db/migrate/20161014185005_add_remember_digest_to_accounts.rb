class AddRememberDigestToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :remember_digest, :string
  end
end
