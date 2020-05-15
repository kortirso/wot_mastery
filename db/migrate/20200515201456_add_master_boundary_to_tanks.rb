class AddMasterBoundaryToTanks < ActiveRecord::Migration[6.0]
  def change
    add_column :tanks, :master_boundary, :integer
  end
end
