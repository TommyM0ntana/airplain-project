class AddDefaultValueToFlightExecution < ActiveRecord::Migration[6.0]
  def change
    change_column :flight_executions, :status, :string, default: 'scheduled'
  end
end