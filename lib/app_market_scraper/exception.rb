module AppMarketScraper
  class AppMarketScraperError < StandardError; 
    def initialize(string)
      # AppMarketScraper.log.error(string)
      puts "[ERROR::AppMarketScraper][#{AppMarketScraper.current_time}]  #{string}"
    end
  end

  class AppMarketScraperArrayError < AppMarketScraperError
    def initialize(string)
      # AppMarketScraper.log.error(string)
      puts "[ERROR::ArrayError][#{AppMarketScraper.current_time}] #{string}"
    end
  end
  
  class ResponseError < AppMarketScraperError
    def initialize(string)
      # AppMarketScraper.log.info(string)
      puts "[ERROR::Response][#{AppMarketScraper.current_time}]  #{string}"
    end
  end
  class NotFoundError < ResponseError; 
    def initialize(string)
      # AppMarketScraper.log.info(string)
      puts "[ERROR::Notfound][#{AppMarketScraper.current_time}]  #{string}"
    end
  end
  class UnavailableError < ResponseError; 
    def initialize(string)
      # AppMarketScraper.log.info(string)
      puts "[ERROR::Unavaliable][#{AppMarketScraper.current_time}]  #{string}"
    end
  end

  class ParserError < AppMarketScraperError
    def initialize(string)
      # AppMarketScraper.log.info(string)
      puts "[ERROR::Parser][#{AppMarketScraper.current_time}]  #{string}"
    end
  end

  class ParamsError < AppMarketScraperError
    def initialize(string)
      # AppMarketScraper.log.info(string)
      puts "[ERROR::Params][#{AppMarketScraper.current_time}]  #{string}"
    end
  end

end

# log.debug('debug')
# log.info('info')
# log.warn('warn')
# log.error('error')
# log.fatal('fatal')
# log.unknown('='*80)
# log.level=Logger::INFO
# log.debug('debug')
# log.info('info')
# log.warn('warn')
# log.error('error')
# log.fatal('fatal')
# log.unknown('='*80)
# log.level=Logger::FATAL
# log.debug('debug')
# log.info('info')
# log.warn('warn')
# log.error('error')
# log.fatal('fatal')
# log.unknown('+'*80)