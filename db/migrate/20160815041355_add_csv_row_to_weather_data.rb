class AddCsvRowToWeatherData < ActiveRecord::Migration
  def change
    add_column :weather_data, :csv_row, :string
  end
end
