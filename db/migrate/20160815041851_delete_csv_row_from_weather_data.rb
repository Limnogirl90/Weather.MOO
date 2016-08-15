class DeleteCsvRowFromWeatherData < ActiveRecord::Migration
  def change
    remove_column :weather_data, :csv_row, :string
  end
end
