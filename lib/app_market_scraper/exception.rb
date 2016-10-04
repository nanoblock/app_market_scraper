module AppMarketScraper
  class AppMarketScraperError < StandardError; 
    def initialize(string)
      puts "[ERROR::AppMarketScraper][#{Time.now}]  #{string}"
    end
  end
  
  class ResponseError < AppMarketScraperError
    def initialize(string)
      puts "[ERROR::RESPONSE][#{Time.now}]  #{string}"
    end
  end
  class NotFoundError < ResponseError; 
    def initialize(string)
      puts "[ERROR::NOTFOUND][#{Time.now}]  #{string}"
    end
  end
  class UnavailableError < ResponseError; 
    def initialize(string)
      puts "[ERROR::UNAVAILABLE][#{Time.now}]  #{string}"
    end
  end

  class ParserError < AppMarketScraperError
    def initialize(string)
      puts "[ERROR::PARSER][#{Time.now}]  #{string}"
    end
  end

  class ParamsError < AppMarketScraperError
    def initialize(string)
      puts "[ERROR::PARAMS][#{Time.now}]  #{string}"
    end
  end

end