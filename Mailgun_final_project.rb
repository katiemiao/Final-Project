# Initialize your Mailgun object:
  require 'Mailgun'
  require 'nokogiri'
  require 'open-uri'

class Weather
  attr_reader :right_now_temperature, 
  :right_now_forecast, 
  :past_24_hr_precipitation, 
  :today_temperature, 
  :today_forecast, 
  :today_rain, 
  :tonight_temperature, 
  :tonight_forecast, 
  :tonight_rain

  def initialize
    html = "http://www.weather.com/weather/today/USCT0085:1"

    doc = Nokogiri::HTML(open(html))

    @right_now_temperature = doc.css('.wx-temperature').children.children.first.text
    @right_now_forecast = doc.css('.wx-phrase').children.first.text
    @past_24_hr_precipitation = doc.css('.wx-data').children.first.text

    @today_temperature = doc.css('.wx-temperature').children[2].text
    @today_forecast = doc.css('.wx-phrase').children[1].text
    @today_rain = doc.css('.wx-data').children[2].text

    @tonight_temperature = doc.css('.wx-temperature').children[4].text
    @tonight_forecast = doc.css('.wx-phrase').children[2].text
    @tonight_rain = doc.css('.wx-data').children[4].text
  end 
end


class Mail
  def initialize
    today = Weather.new

    Mailgun.configure do |config|
      config.api_key = 'key-103ef26833fb6c69c948f92425316e89'
      config.domain  = 'sandboxac2031ed08e14602b4e69d309e603313.mailgun.org'


    @mailgun = Mailgun()

    # or alternatively:
    # @mailgun = Mailgun(:api_key => 'your-api-key')

    parameters = {
      :to => "katiemiao61@gmail.com",
      :subject => "Weather",
      :text => "Right Now's Temperature: #{today.right_now_temperature}
Right Now's Forecast: #{today.right_now_forecast}
Past 24 hr Precipitation: #{today.past_24_hr_precipitation}

Today's Temperature: #{today.today_temperature}
Today's Forecast: #{today.today_forecast}
Today's Chance of Rain: #{today.today_rain}

Tonight's Temperature: #{today.tonight_temperature}
Tonight's Forecast: #{today.tonight_forecast}
Tonight's Chance of Rain: #{today.tonight_rain}
",
      :from => "WeatherReport@gmail.com"
    }
    @mailgun.messages.send_email(parameters)
  end
end
end

#Mail.new

#Rakefile
# require_relative 'Mailgun_final_project.rb'
# task :send_weather do
  # mail = Mail.new
# end
