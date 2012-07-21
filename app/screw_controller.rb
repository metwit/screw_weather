class ScrewController < UIViewController

  def init
    super.tap do
      get_yahoo_woeid(45,9)
    end
  end
  
  
  # Return the weather from Yahoo
  def get_yahoo_weather
    
  end

  # Return Yahoo woeid
  def get_yahoo_woeid(lat, lng)
    url = "http://where.yahooapis.com/geocode?q=#{lat},#{lng}&gflags=R"
    woeid = nil
    BubbleWrap::HTTP.get(url) do |response|
      woeid = response.body.to_s[/<woeid>(\d+)<\/woeid>/,1]
    end
    woeid          
  end
    
end
