class AddProducerToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :producer, foreign_key: true
  end
end
