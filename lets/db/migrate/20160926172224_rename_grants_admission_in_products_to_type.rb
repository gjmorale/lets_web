class RenameGrantsAdmissionInProductsToType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :products, :grants_admission, :product_type
  end
end
