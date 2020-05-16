class CreateExperienceCoefficients < ActiveRecord::Migration[6.0]
  def change
    create_table :experience_coefficients do |t|
      t.integer :tank_id
      t.integer :bonus
      t.integer :kill
      t.integer :damage
      t.integer :assist
      t.integer :block
      t.timestamps
    end
    add_index :experience_coefficients, :tank_id
  end
end
