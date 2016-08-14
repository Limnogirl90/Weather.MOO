class CreateWeatherData < ActiveRecord::Migration
  def change
    create_table :weather_data do |t|
      t.date :observation_date

      t.timestamps null: false
    end
  end
end
