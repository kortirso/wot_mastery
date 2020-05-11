class AddDateToBattleResults < ActiveRecord::Migration[6.0]
  def change
    add_column :battle_results, :date, :date
  end
end
