class RenameUsersToUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :passengers, :users_id, :user_id
    rename_column :passengers, :flights_id, :flight_id 
  end
end
