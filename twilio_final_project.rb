  require 'rubygems' # not necessary with ruby 1.9 but included for completeness
  require 'twilio-ruby'
  require 'nokogiri'
  require 'open-uri'

  html = 'http://www.weather.com/weather/today/USCT0085:1'

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

class Text

  def initialize(receiver, message)
    @receiver=receiver
    @message=message
  # put your own credentials here
  account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
  auth_token = '2008ea097713e401a16c54029058da82'

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new account_sid, auth_token

  @client.account.messages.create(
    :from => '+18152642023',
    :to => @receiver,
    :body => @message
  )
  end

end

Text.new("+12039188371", "Right Now's Temperature: #{Right_Now_Temperature}
Right Now's Forecast: #{Right_Now_Forecast}
Past 24 hr Precipitation: #{Past_24_hr_Precipitation}

Today's Temperature: #{Today_Temperature}
Today's Forecast: #{Today_Forecast}
Today's Chance of Rain: #{Today_Rain}

Tonight's Temperature: #{Tonight_Temperature}
Tonight's Forecast: #{Tonight_Forecast}
Tonight's Chance of Rain: #{Tonight_Rain}
")




