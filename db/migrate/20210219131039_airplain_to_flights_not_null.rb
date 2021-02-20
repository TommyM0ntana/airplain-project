class AirplainToFlightsNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :flights, :airplain_id, true
  end
end
