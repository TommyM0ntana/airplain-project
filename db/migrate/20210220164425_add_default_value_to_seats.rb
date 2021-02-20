class AddDefaultValueToSeats < ActiveRecord::Migration[6.0]
  def change
    change_column :seats, :seat_class, :string, null: false
    change_column :seats, :near_exit, :boolean, default: false
    change_column :seats, :extra_leg_space, :boolean, default: false
    change_column :seats, :window_seat, :boolean, default: false
  end
end