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
  WeatherDatum.transaction do
    if w.weather_html_url.nil?
      url = WeatherDatum.weather_url_from_date(d)
      w.weather_html_url = url
    end
    if w.observation_date.nil?
      w.observation_date = d
    end
    if w.csv_row.nil?
      w.csv_row = Marshal.dump(w.weather_data_row)
    end
    w.save
  end
  csv_row = Marshal.load(w.csv_row)
  unless csv_row.key?(:"Heating Degree Days")
    csv_row[:"Heating Degree Days"] = "NA"
  end
  unless csv_row.key?(:"Growing Degree Days")
    csv_row[:"Growing Degree Days"] = "NA"
  end
  unless csv_row.key?(:"Cooling Degree Days")
    csv_row[:"Cooling Degree Days"] = "NA"
  end
  if header.nil?
    header = csv_row.keys
  end
  rows << csv_row
end
puts header.to_csv
rows.each do |row|
  puts header.map {|h| row[h]}.to_csv
end
