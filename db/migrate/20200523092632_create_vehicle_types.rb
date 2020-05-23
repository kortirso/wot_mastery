class CreateVehicleTypes < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    create_table :tanks_types do |t|
      t.integer :name, default: 0
      t.timestamps
    end

    add_column :tanks, :tanks_type_id, :integer
    add_index :tanks, :tanks_type_id, algorithm: :concurrently
    safety_assured { remove_column :tanks, :type }
  end
end
