class CreateBattleResults < ActiveRecord::Migration[6.0]
  def change
    create_table :battle_results do |t|
      t.integer :tank_id
      t.integer :experience
      t.integer :damage
      t.integer :assist
      t.integer :block
      t.integer :medal
      t.integer :source, null: false, default: 0
      t.string :external_id, null: false
      t.timestamps
    end
    add_index :battle_results, :tank_id
  end
end
