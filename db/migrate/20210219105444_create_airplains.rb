class CreateAirplains < ActiveRecord::Migration[6.0]
  def change
    create_table :airplains do |t|
      t.string :model
      t.integer :first_class
      t.integer :executive_class
      t.integer :economic_class

      t.timestamps
    end
  end
end
