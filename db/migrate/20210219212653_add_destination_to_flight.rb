class AddDestinationToFlight < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :destination, :string
  end
end
