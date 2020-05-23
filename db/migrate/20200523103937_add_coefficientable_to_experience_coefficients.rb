class AddCoefficientableToExperienceCoefficients < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_column :experience_coefficients, :coefficientable_id, :integer
    add_column :experience_coefficients, :coefficientable_type, :string
    add_index :experience_coefficients, [:coefficientable_id, :coefficientable_type], algorithm: :concurrently, name: 'experience_index'
    safety_assured { remove_column :experience_coefficients, :tank_id }
  end
end
