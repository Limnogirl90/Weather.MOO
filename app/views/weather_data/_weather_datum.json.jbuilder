json.extract! weather_datum, :id, :observation_date, :created_at, :updated_at
json.url weather_datum_url(weather_datum, format: :json)