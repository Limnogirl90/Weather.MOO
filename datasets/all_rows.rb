require 'csv'

csv_table = nil
rows = []
header = nil
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
  csv_row.delete(:"Heating Degree Days")
  unless csv_row.key?(:"Growing Degree Days")
    csv_row[:"Growing Degree Days"] = "NA"
  end
  if header.nil?
    header = csv_row.keys
  end
  rows << csv_row
end
#STDERR.puts "printing out a big old CSV"
puts header.to_csv
rows.each do |row|
  puts header.map {|h| row[h]}.to_csv
end
#puts csv_table
