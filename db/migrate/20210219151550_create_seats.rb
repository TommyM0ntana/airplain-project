class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.references :flight, foreign_key: true
      t.references :passenger, foreign_key: true
      t.string :type
      t.boolean :near_exit
      t.boolean :extra_leg_space
      t.boolean :window_seat

      t.timestamps
    end
  end
end
