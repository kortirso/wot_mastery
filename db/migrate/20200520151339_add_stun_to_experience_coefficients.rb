class AddStunToExperienceCoefficients < ActiveRecord::Migration[6.0]
  def change
    add_column :experience_coefficients, :stun, :integer, default: 0
  end
end
