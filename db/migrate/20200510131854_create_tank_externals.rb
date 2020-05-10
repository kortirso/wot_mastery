class CreateTankExternals < ActiveRecord::Migration[6.0]
  def change
    create_table :tank_externals do |t|
      t.integer :tank_id
      t.integer :source, null: false, default: 0
      t.string :external_id, null: false
      t.timestamps
    end
    add_index :tank_externals, :tank_id
  end
end
