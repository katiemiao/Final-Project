  require 'rubygems' # not necessary with ruby 1.9 but included for completeness
  require 'twilio-ruby'
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
    html = 'http://www.weather.com/weather/today/USCT0085:1'

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


class Text

  def initialize(receiver)
    today = Weather.new
    @receiver = receiver

  # put your own credentials here
    account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
    auth_token = '2008ea097713e401a16c54029058da82'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create(
      :from => '+18152642023',
      :to => @receiver,
      :body => "Now's Temperature: #{today.right_now_temperature}
Now's Forecast: #{today.right_now_forecast}
Past 24 hr Precipitation: #{today.past_24_hr_precipitation}

Today's High: #{today.today_temperature}
Today's Forecast: #{today.today_forecast}
Today's Chance of Rain: #{today.today_rain}

Tonight's Low: #{today.tonight_temperature}
Tonight's Forecast: #{today.tonight_forecast}
Tonight's Chance of Rain: #{today.tonight_rain}
")
  end

end

# Text.new("+12039188371")