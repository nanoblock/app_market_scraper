require 'addressable/uri'
require 'typhoeus'
require 'nokogiri'
require 'thread'
require 'parallel'
require 'csv'
require 'logger'

require "app_market_scraper/version"
require 'app_market_scraper/exception'
require 'app_market_scraper/url'

require 'app_market_scraper/util/network'
require 'app_market_scraper/util/app_market_scraper_array'
require 'app_market_scraper/util/app_array'

require 'app_market_scraper/play/play'
require 'app_market_scraper/play/constants'
require 'app_market_scraper/play/content/app'
require 'app_market_scraper/play/search/scraper'
require 'app_market_scraper/play/search/parser'
require 'app_market_scraper/play/detail/scraper'
require 'app_market_scraper/play/detail/parser'
require 'app_market_scraper/play/category/scraper'
require 'app_market_scraper/play/category/parser'


module AppMarketScraper
  DEFAULT_LANG = 'ko'
  DEFAULT_COUNTRY = 'ko'
  DEFAULT_APP_LIMIT = 200
  SCRAPED_APP_COUNT = 0
  CURRENT_TIME = Time.now
  DEFAULT_LOG_PATH = File.expand_path("../../../app_market_scraper.log", __FILE__)

  def self.lang
    @lang ||= DEFAULT_LANG
  end

  def self.lang=(value)
    @lang = value
  end

  def self.country
    @country ||= DEFAULT_COUNTRY
  end

  def self.country=(value)
    @country = value
  end

  def self.mutex
    @mutext ||= Mutex.new
  end

  def self.app_limit
    @app_limit ||= DEFAULT_APP_LIMIT
  end

  def self.app_limit=(value)
    @app_limit = value
  end

  def self.current_time
    @time ||= CURRENT_TIME
  end

  def self.current_time=(value)
    @time = value    
  end

  def self.play_scrap_counter
    @count ||= SCRAPED_APP_COUNT
    @count = @count.next
    puts "[#{Time.now}]  Google Apps scraping succeeded!!
    \tscraped app count   -> #{current_size}
    \tcurrent speed       -> #{current_speed} app/s
    \taver speed          -> #{aver_speed}"
  end

  def self.current_speed
    ((Time.now - AppMarketScraper.current_time) / @count).round(3)
  end

  def self.sum_speed(value)
    @speed_aver = (value.to_f + @speed_aver.to_f).round(3)
  end

  def self.aver_speed
    (sum_speed(current_speed) / current_size).round(3)
  end

  def self.current_size
    @count ||= AppMarketScraper::Play.array.size
  end

  def self.log
    # STDOUT
    @log ||= Logger.new(DEFAULT_LOG_PATH)
    @log
  end

end
