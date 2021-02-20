class CreateFlightExecutions < ActiveRecord::Migration[6.0]
  def change
    create_table :flight_executions do |t|
      t.references :flight, null: false, foreign_key: true
      t.string :status
      t.boolean :delayed
      t.boolean :canceled
      t.datetime :departure

      t.timestamps
    end
  end
end
