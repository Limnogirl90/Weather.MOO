class AddCsvRow2ToWeatherData < ActiveRecord::Migration
  def change
    add_column :weather_data, :csv_row, :binary
  end
end
