class AddResultToBattleResults < ActiveRecord::Migration[6.0]
  def change
    add_column :battle_results, :win, :boolean, default: false
  end
end
