module AppMarketScraper
  class AppMarketScraperError < StandardError; 
    def initialize(string)
      p "[ERROR::AppMarketScraper] #{string}"
    end
  end
  
  class ResponseError < AppMarketScraperError
    def initialize(string)
      p "[ERROR::RESPONSE] #{string}"
    end
  end
  class NotFoundError < ResponseError; 
    def initialize(string)
      p "[ERROR::NOTFOUND] #{string}"
    end
  end
  class UnavailableError < ResponseError; 
    def initialize(string)
      p "[ERROR::UNAVAILABLE] #{string}"
    end
  end
end