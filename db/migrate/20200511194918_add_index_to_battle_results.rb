class AddIndexToBattleResults < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :battle_results, :external_id, algorithm: :concurrently
  end
end
