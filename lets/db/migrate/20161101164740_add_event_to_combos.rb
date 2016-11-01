class AddEventToCombos < ActiveRecord::Migration[5.0]
  def change
    add_reference :combos, :event, foreign_key: true
  end
end
