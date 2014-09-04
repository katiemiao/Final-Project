# require 'nokogiri'
# require 'open-uri'

# html = "http://www.weather.com/weather/today/USCT0085:1"

# doc = Nokogiri::HTML(open(html))

# right_now_temperature = doc.css('.wx-temperature').children.children.first.text
# right_now_forecast = doc.css('.wx-phrase').children.first.text
# past_24_hr_precipitation = doc.css('.wx-data').children.first.text

# today_temperature = doc.css('.wx-temperature').children[2].text
# today_forecast = doc.css('.wx-phrase').children[1].text
# today_rain = doc.css('.wx-data').children[2].text

# tonight_temperature = doc.css('.wx-temperature').children[4].text
# tonight_forecast = doc.css('.wx-phrase').children[2].text
# tonight_rain = doc.css('.wx-data').children[4].text