require 'csv'

csv_table = nil
rows = []
WeatherDatum.all.each do |w|
  d = w.weather_data_date
  url = WeatherDatum.weather_url_from_date(d)
  if w.weather_html_url.nil?
    w.weather_html_url = url
    w.save
  end
  puts "caching weather data for #{d} locally"
  csv_row = w.weather_data_row
  rows << CSV::Row.new(csv_row.keys, csv_row.values)
end
puts "printing out a big old CSV"
csv_table = CSV::Table.new(rows)
puts csv_table
