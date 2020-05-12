class AddKillAmountToBattleResults < ActiveRecord::Migration[6.0]
  def change
    add_column :battle_results, :killed_amount, :integer, default: 0
  end
end
