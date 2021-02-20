class UpdateTelephoneNumberString < ActiveRecord::Migration[6.0]
  def change
    change_column :passengers, :telephone_number, :string 
  end
end