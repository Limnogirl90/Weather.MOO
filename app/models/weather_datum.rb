class WeatherDatum < ActiveRecord::Base
  attachment :weather_html

  def self.weather_url_from_date( d )
    year = d.year
    month = d.month
    day = d.day
    # iso = d.iso8601
    url = "https://www.wunderground.com/history/airport/KELM/#{year}/#{month}/#{day}/DailyHistory.html"
  end

  def weather_data_date
    if @html.nil?
      @html = weather_html.read
    end
    if @doc.nil?
      @doc = Nokogiri::HTML(@html)
    end
    d = @doc.css('//h2.history-date')
    Date.strptime(d.text, "%A, %B %d, %Y")
  end

  def weather_data_row
    if @html.nil?
      @html = weather_html.read
    end
    if @doc.nil?
      @doc = Nokogiri::HTML(@html)
    end
    d = @doc.css('table#historyTable')
    headers = []
    d.xpath('.//thead/tr/th').each do |th|
      headers << th.text.strip
    end
    headers << "Year"
    headers << "Month"
    headers << "Day"
    rows = []
    d.xpath('.//tbody/tr').each_with_index do |row, i|
      rows[i] = {}
      row.xpath('td').each_with_index do |td, j|
        rows[i][headers[j]] = td.text.strip
      end
    end
    t = rows.select do |r|
      label = r["\u00a0"]
      ( label =~ /Mean Temperature|Max Temperature|Min Temperature|Cooling Degree Days|Heating Degree Days|Growing Degree Days|Precipitation/ &&
       (label==:Precipitation && r["Actual"].nil? ? false : true)
      )
    end
    ret = t.map{ |r| { "#{r["\u00a0"]}": r["Actual"].split(/[[:space:]]/)[0]} }.inject :merge
    weather_date = weather_data_date
    ret[:Year] = weather_date.year
    ret[:Month] = weather_date.month
    ret[:Day] = weather_date.day
    ret
  end
end
