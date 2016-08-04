class AddNewColumnsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :open_date, :datetime
    add_column :events, :close_date, :datetime
  end
end
