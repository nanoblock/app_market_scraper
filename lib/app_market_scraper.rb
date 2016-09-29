require 'addressable/uri'
require 'typhoeus'
require 'nokogiri'

require "app_market_scraper/version"
require 'app_market_scraper/exception'
require 'app_market_scraper/util'
require 'app_market_scraper/url'
require 'app_market_scraper/play/constants'
require 'app_market_scraper/play/app'
require 'app_market_scraper/play/scraper'

module AppMarketScraper

  def self.timeout
    @timeout ||= 100
  end

  def self.timeout=(val)
    @timeout = val
  end

  def self.connect_timeout
    @connect_timeout ||= 100
  end

  def self.connect_timeout=(val)
    @connect_timeout = val
  end

	# github 주소 바꾸기
  def self.user_agent
    @user_agent ||= "AppMarketScraper/#{AppMarketScraper::VERSION} / " \
    "(+https://github.com/nanoblock/app_market_scraper)"
  end

  def self.user_agent=(val)
    @user_agent = val
  end

end
