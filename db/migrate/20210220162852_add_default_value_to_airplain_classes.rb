class AddDefaultValueToAirplainClasses < ActiveRecord::Migration[6.0]
  def change
    change_column :airplains, :first_class, :integer, null: false
    change_column :airplains, :executive_class, :integer, null: false
    change_column :airplains, :economic_class, :integer, null: false
  end
end
