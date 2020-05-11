class AddStatsForTanks < ActiveRecord::Migration[6.0]
  def change
    add_column :tanks, :health, :integer
    add_column :tanks, :damage_per_shot, :integer
  end
end
