# Initialize your Mailgun object:
  require 'Mailgun'
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

class Mail

  def initialize(message)
    @message = message

    Mailgun.configure do |config|
      config.api_key = 'key-103ef26833fb6c69c948f92425316e89'
      config.domain  = 'sandboxac2031ed08e14602b4e69d309e603313.mailgun.org'
    end


    @mailgun = Mailgun()

    # or alternatively:
    # @mailgun = Mailgun(:api_key => 'your-api-key')

    parameters = {
      :to => "katiemiao61@gmail.com",
      :subject => "Weather",
      :text => @message,
      :from => "WeatherReport@gmail.com"
    }
    @mailgun.messages.send_email(parameters)
  end
end

Mail.new("Right Now's Temperature: #{Right_Now_Temperature}
Right Now's Forecast: #{Right_Now_Forecast}
Past 24 hr Precipitation: #{Past_24_hr_Precipitation}

Today's Temperature: #{Today_Temperature}
Today's Forecast: #{Today_Forecast}
Today's Chance of Rain: #{Today_Rain}

Tonight's Temperature: #{Tonight_Temperature}
Tonight's Forecast: #{Tonight_Forecast}
Tonight's Chance of Rain: #{Tonight_Rain}
")


