class CreateProducers < ActiveRecord::Migration[5.0]
  def change
    create_table :producers do |t|
      t.string :name
      t.string :fantasy_name
      t.string :social_id

      t.timestamps
    end
  end
end
