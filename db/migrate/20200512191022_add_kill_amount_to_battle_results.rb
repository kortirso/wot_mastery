class AddKillAmountToBattleResults < ActiveRecord::Migration[6.0]
  def up
    add_column :battle_results, :killed_amount, :integer
    change_column_default :battle_results, :killed_amount, 0
  end

  def down
    remove_column :battle_results, :killed_amount
  end
end
