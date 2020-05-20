class AddPrecisionToCoefficients < ActiveRecord::Migration[6.0]
  def change
    add_column :experience_coefficients, :precision, :integer, default: 0
  end
end
