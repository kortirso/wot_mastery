class ChangeExperienceCoefficientsDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :experience_coefficients, :bonus, from: nil, to: 0
    change_column_default :experience_coefficients, :kill, from: nil, to: 0
    change_column_default :experience_coefficients, :damage, from: nil, to: 0
    change_column_default :experience_coefficients, :assist, from: nil, to: 0
    change_column_default :experience_coefficients, :block, from: nil, to: 0

  end
end
