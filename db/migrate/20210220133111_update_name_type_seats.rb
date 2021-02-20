class UpdateNameTypeSeats < ActiveRecord::Migration[6.0]
  def change
    rename_column :seats, :type, :seat_class
  end
end
