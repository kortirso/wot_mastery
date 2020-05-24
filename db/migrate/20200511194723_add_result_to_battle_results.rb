class AddResultToBattleResults < ActiveRecord::Migration[6.0]
  def up
    add_column :battle_results, :win, :boolean
    change_column_default :battle_results, :win, false
  end

  def down
    remove_column :battle_results, :win
  end
end
