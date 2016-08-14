class AddWeatherHtmlUrlToWeatherData < ActiveRecord::Migration
  def change
    add_column :weather_data, :weather_html_url, :string
  end
end
