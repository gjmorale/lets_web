class CreateAdmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :admissions do |t|
      t.integer :status

      t.timestamps
    end
  end
end
