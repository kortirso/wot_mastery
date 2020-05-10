class CreateTanks < ActiveRecord::Migration[6.0]
  def change
    create_table :tanks do |t|
      t.jsonb :name
      t.integer :tier, null: false, default: 1
      t.integer :type, null: false, default: 0
      t.integer :country_id, null: false
      t.timestamps
    end
    add_index :tanks, :country_id
  end
end
