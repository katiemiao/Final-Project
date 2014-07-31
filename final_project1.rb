require 'nokogiri'
require 'open-uri'

html = "http://www.weather.com/weather/today/USCT0085:1"

doc = Nokogiri::HTML(open(html))

Right_Now_Temperature = doc.css('.wx-temperature').children.children.first.text
Right_Now_Forecast = doc.css('.wx-phrase').children.first.text
Past_24_hr_Precipitation = doc.css('.wx-data').children.first.text

Today_Temperature = doc.css('.wx-temperature').children[2].text
Today_Forecast = doc.css('.wx-phrase').children[1].text
Today_Rain = doc.css('.wx-data').children[2].text

Tonight_Temperature = doc.css('.wx-temperature').children[4].text
Tonight_Forecast = doc.css('.wx-phrase').children[2].text
Tonight_Rain = doc.css('.wx-data').children[4].text
