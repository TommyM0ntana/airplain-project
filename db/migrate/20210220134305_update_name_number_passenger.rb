class UpdateNameNumberPassenger < ActiveRecord::Migration[6.0]
  def change
    rename_column :passengers, :telephone_numbre, :telephone_number
  end
end
