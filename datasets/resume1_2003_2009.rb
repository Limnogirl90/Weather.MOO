require 'csv'

date_range = Date.new(2005,5,17)..Date.new(2009,12,31)

csv_table = nil
rows = []
date_range.each do |d|
  url = WeatherDatum.weather_url_from_date(d)
  w = WeatherDatum.new
  puts "snagging weather data for #{d}"
  w.remote_weather_html_url = url
  w.save

  csv_row = w.weather_data_row
  rows << CSV::Row.new(csv_row.keys, csv_row.values)

end

csv_table = CSV::Table.new(rows)

