# Initialize your Mailgun object:
  require 'open-uri'
  require 'nokogiri'
  require 'mailgun'
  require_relative 'twilio_final_project.rb'


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
      :text => "Now's Temperature: #{today.right_now_temperature}
Now's Forecast: #{today.right_now_forecast}
Past 24 hr Precipitation: #{today.past_24_hr_precipitation}

Today's High: #{today.today_temperature}
Today's Forecast: #{today.today_forecast}
Today's Chance of Rain: #{today.today_rain}

Tonight's Low: #{today.tonight_temperature}
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

