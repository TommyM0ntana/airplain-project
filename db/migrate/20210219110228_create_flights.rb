class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.references :airplain, null: false, foreign_key: true
      t.string :origin
      t.integer :duration
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
