class ScrewController < UIViewController

  def init
    super.tap do
      get_yahoo_weather(45,9) do |status|
        puts status*100
      end
      
    end
  end

  def convert_yahoo_code(yahoo_code)
    case yahoo_code
    when 0,1,2,3,4
      :stormy
    when 5,6,7,8,13,18
      :snow_flurries
    when 9,10,11,12,40
      :rainy
    when 14,15,16,41,42,43,46
      :snowy
    when 17
      :hail
    when 19,20,21,22
      :fog
    when 23,24
      :windy
    when 26,27,28
      :cloudy
    when 29,30,44
      :party_cloudy
    when 31,32,33,34
      :clear
    when 35
      :hail
    when 37,38,39,45,47
      :stormy
    else
      :uknown
    end
    
  end
    
  # Return the weather from Yahoo
  def get_yahoo_weather(lat, lng, &block)
    url = "http://where.yahooapis.com/geocode?q=#{lat},#{lng}&gflags=R"
    BubbleWrap::HTTP.get(url) do |response|
      if response.ok?
        woeid = response.body.to_s[/<woeid>(\d+)<\/woeid>/,1]
        url = "http://weather.yahooapis.com/forecastrss?w=#{woeid}"
        BubbleWrap::HTTP.get(url) do |response|
          if response.ok?
            status_code = response.body.to_s[/code="(\d+)"/,1]
            block.call convert_yahoo_code(status_code)
          else
            puts response.error_message
          end
        end
      else
        puts response.error_message
      end
    end
  end

end
