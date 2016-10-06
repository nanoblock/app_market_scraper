require 'addressable/uri'
require 'typhoeus'
require 'nokogiri'
require 'thread'
# require 'csv'

require "app_market_scraper/version"
require 'app_market_scraper/exception'
require 'app_market_scraper/url'

require 'app_market_scraper/util/util'
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


module AppMarketScraper
  DEFAULT_LANG = 'ko'
  DEFAULT_COUNTRY = 'ko'
  DEFAULT_THREAD_LIMIT = 500
  DEFAULT_APP_LIMIT = 15000
  CURRENT_TIME = Time.now

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

  def self.threads
    # @threads ||= []
    @threads ||= AppMarketScraper::Util::AppMarketScraperArray.new
  end

  def self.thread_limit
    @thread_limit ||= DEFAULT_THREAD_LIMIT
  end

  def self.thread_limit(value)
    @thread_limit = value
  end
  
  def self.threads=(value)
    @threads = value
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

end
