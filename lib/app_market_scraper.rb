require 'addressable/uri'
require 'typhoeus'
require 'nokogiri'

require "app_market_scraper/version"
require 'app_market_scraper/exception'
require 'app_market_scraper/url'

require 'app_market_scraper/util/util'
require 'app_market_scraper/util/network'
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

end
