class AddWeatherHtmlToWeatherData < ActiveRecord::Migration
  def change
    add_column :weather_data, :weather_html_id, :string
    add_column :weather_data, :weather_html_filename, :string
    add_column :weather_data, :weather_html_size, :integer
    add_column :weather_data, :weather_html_content_type, :string
  end
end
