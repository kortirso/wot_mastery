class AddValueToTanksTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :tanks_types, :value, :string
  end
end
