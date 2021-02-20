class AddDefaultValueDelayedAndCancelled < ActiveRecord::Migration[6.0]
  def change
    change_column :flight_executions, :delayed, :boolean, default: false
    change_column :flight_executions, :canceled, :boolean, default: false
  end
end
