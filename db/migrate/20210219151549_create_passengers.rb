class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.references :users, foreign_key: true
      t.references :flights, foreign_key: true
      t.string :email
      t.string :full_name
      t.string :national_id
      t.integer :telephone_numbre

      t.timestamps
    end
  end
end
