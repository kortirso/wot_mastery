class AddStunToBattleResults < ActiveRecord::Migration[6.0]
  def up
    add_column :battle_results, :stun, :integer
    change_column_default :battle_results, :stun, 0
  end

  def down
    remove_column :battle_results, :stun
  end
end
