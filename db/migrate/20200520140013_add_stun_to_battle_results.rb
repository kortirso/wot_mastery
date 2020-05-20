class AddStunToBattleResults < ActiveRecord::Migration[6.0]
  def change
    add_column :battle_results, :stun, :integer, default: 0
  end
end
