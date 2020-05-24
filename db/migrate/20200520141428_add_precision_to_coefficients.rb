class AddPrecisionToCoefficients < ActiveRecord::Migration[6.0]
  def change
    add_column :experience_coefficients, :precision, :integer
    change_column_default :experience_coefficients, :precision, 0
  end

  def down
    remove_column :experience_coefficients, :precision
  end
end
