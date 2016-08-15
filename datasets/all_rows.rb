require 'csv'

csv_table = nil
rows = []
WeatherDatum.all.each do |w|
  d = nil
  if w.csv_row.nil?
    d = w.weather_data_date
  else
    d = w.observation_date
  end
  puts "caching weather data for #{d} locally"
  WeatherDatum.transaction do
    if w.weather_html_url.nil?
      url = WeatherDatum.weather_url_from_date(d)
      puts "updating URL field"
      w.weather_html_url = url
    end
    if w.observation_date.nil?
      puts "updating observation_date field"
      w.observation_date = d
    end
    if w.csv_row.nil?
      puts "saving CSV data"
      w.csv_row = Marshal.dump(w.weather_data_row)
    end
    w.save
  end
  csv_row = Marshal.load(w.csv_row)
  rows << CSV::Row.new(csv_row.keys, csv_row.values)
end
puts "printing out a big old CSV"
csv_table = CSV::Table.new(rows)
puts csv_table
