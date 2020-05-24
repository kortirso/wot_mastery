class AddStunToExperienceCoefficients < ActiveRecord::Migration[6.0]
  def change
    add_column :experience_coefficients, :stun, :integer
    change_column_default :experience_coefficients, :stun, 0
  end

  def down
    remove_column :experience_coefficients, :stun
  end
end
