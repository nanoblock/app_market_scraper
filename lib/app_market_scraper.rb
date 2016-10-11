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
  DEFAULT_THREAD_LIMIT = 100
  DEFAULT_APP_LIMIT = 200
  SCRAPED_APP_COUNT = 0
  CURRENT_TIME = Time.now
  DEFAULT_LOG_PATH = File.expand_path("../../../app_market_scraper.log", __FILE__)
  DEFAULT_BASE_PATH = File.expand_path("../../../smta_play_ko_writer.csv", __FILE__)

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

  def self.thread_limit=(value)
    @thread_limit = value
  end

  def self.thread_limit
    @thread_limit ||= DEFAULT_THREAD_LIMIT
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
    @time = CURRENT_TIME
  end

  def self.current_time=(value)
    @time = value    
  end

  def self.play_scrap_counter
    @time_count ||= 0
    @time_count = @time_count.next

    logger = "\n[#{Time.now}]  Google Apps scraping succeeded!!
    \tscraped app count               -> #{current_size}
    \tcurrent speed                   -> #{current_speed} app/s
    \taver speed                      -> #{aver_speed} app/s
    \ttake time                       -> #{seconds_to_time(take_time)}
    \testimated_time_of_completion    -> #{seconds_to_time(estimated_time_of_completion)} app/s
    \tbackup?                         -> #{AppMarketScraper.backup_start?}" 
    puts logger
    AppMarketScraper.log.debug(logger)
  end

  def self.current_speed
    (AppMarketScraper.take_time / @time_count).round(3)
  end

  def self.sum_speed(value)
    @speed_aver = (value.to_f + @speed_aver.to_f).round(3)
  end

  def self.aver_speed
    (sum_speed(current_speed) / @time_count).round(3)
  end

  def self.take_time
    Time.now - AppMarketScraper.current_time
  end

  def self.estimated_time_of_completion
    @remainig_time = (app_limit-current_size) * aver_speed
  end

  def self.seconds_to_time(time)
    #find the seconds
    seconds = time % 60
    #find the minutes
    minutes = (time / 60) % 60
    #find the hours
    hours = (time / 3600)
    "#{hours.to_i} Hours  #{minutes.to_i} Minutes  #{seconds.to_i} Secounds"
  end

  def self.path
    @base_path ||= DEFAULT_BASE_PATH
  end

  def self.path=(value)
    @base_path = value
  end

  def self.log_path
    @log_path ||= DEFAULT_LOG_PATH
  end

  def self.log_path=(value)
    @log_path = value
  end

  def self.csv_read_path
    @csv_read_path ||= nil
  end

  def self.csv_read_path=(value=nil)
    @csv_read_path = value
  end

  def self.current_size
    @count = AppMarketScraper::Play.array.size
  end

  def self.current_size=(value)
    @count = value
  end

  def self.log
    # STDOUT
    @log ||= Logger.new(DEFAULT_LOG_PATH)
    @log
  end

  def self.backup_count
    @backup_counts ||= nil
  end

  def self.backup_count=(value)
    @backup_counts = []
    (AppMarketScraper.app_limit/value).to_i.times { |i| 
      @backup_counts << (i * value) unless (i * value) == 0
    }
    @backup_counts
  end

  def self.backup_start?
    @backup_start ||= false
  end

  def self.backup_start=(value)
    @backup_start = value
  end

  def self.csv_reader(target_path)

    if File.exist?(target_path) 
      AppMarketScraper::AppMarketScraperLogger.new("@@@@@@@@@ CSV Read Start @@@@@@@@@\n")

      apps = AppMarketScraper::Util::AppArray.new
      csv_data = CSV.read(target_path, headers: true, encoding: 'UTF-8')
      csv_data.each_with_index do |data, index|
          app = AppMarketScraper::Play::App.new
          app.name = data["name"]
          app.email = data["email"]
          app.category = data["category"]
          app.developer = data["developer"]
          app.package = data["package"]
          app.stars = data["stars"]
          app.download = data["download"]
          app.updated = data["updated"]
          app.content_rating = data["content_rating"]
          app.version = data["version"]
          app.operating_system = data["operating_system"]
          app.address = data["address"]
          app.description = data["description"]
          app.url = data["url"]
          app.image_url = data["image_url"]
          app.developer_web_site = data["developer_web_site"]
          AppMarketScraper::Play.array.add(app)
      end
      # AppMarketScraper::Play.array.get.each_with_index do |value, index|
      #   AppMarketScraper::Play.array.uniq(value.package)
      #   AppMarketScraper::Play.array.delete_at(index)
      # end
      
      AppMarketScraper::AppMarketScraperLogger.new("CSV READER SUCCESS\n
        \tapp size -> #{AppMarketScraper::Play.array.size}\n")
      
      AppMarketScraper::Play.array.get.shuffle.sample(100).each_with_index {|item, index| 
        AppMarketScraper::Play.package.add(item.package)
      }

      AppMarketScraper.current_size = AppMarketScraper::Play.array.size
    end
  end

  def self.csv_writer

    unless AppMarketScraper.backup_start?
      AppMarketScraper::AppMarketScraperLogger.new("@@@@@@@@ CSV Write Start @@@@@@@@@\n")

      AppMarketScraper.backup_start = true
      Parallel::each(["0"], in_threads: 1) { |not_used|

      header = ["name", "email", "category", "developer", "package", "stars", "download", "updated",
        "content_rating", "version", "operating_system", "address", "description", "url", "image_url",
        "developer_web_site"]

      csv_array = AppMarketScraper::Util::AppArray.new

      AppMarketScraper::Play.array.array.each do |array|
        csv_array << array
      end

      # AppMarketScraper::Play.array.delete_all
      begin
        CSV.open("../smta_play_ko_writer_back.csv", "w+", :headers => header, :write_headers => true) do |csv|
          csv_array.each_with_index do |value, index|
            if index == AppMarketScraper.app_limit
              break
            end
            csv << [value.name, value.email, value.category, value.developer, value.package,
              value.stars, value.download, value.updated, value.content_rating, value.version,
              value.operating_system, value.address, value.description, value.url, value.image_url,
              value.developer_web_site]

          end
        end
        CSV.open("../BABA.csv", "w+", :headers => header, :write_headers => true) do |csv|
          csv_array.each_with_index do |value, index|
            if index == AppMarketScraper.app_limit
              break
            end
            csv << [value.name, value.email, value.category, value.developer, value.package,
              value.stars, value.download, value.updated, value.content_rating, value.version,
              value.operating_system, value.address, value.description, value.url, value.image_url,
              value.developer_web_site]

          end
        end
        AppMarketScraper.backup_start = false
        csv_array.clear
        AppMarketScraper::AppMarketScraperLogger.new("@@@@@@@@@@@@@ E N D @@@@@@@@@@@@@@\n")
      rescue => e
        AppMarketScraper::AppMarketScraperError.new(e)
      end    
      }
    
    end
  end

  def self.thread_exit
    AppMarketScraper.csv_writer

    Thread::list.each {|t| 
      Thread::kill(t)
      # Thread::Kill(t) if t != Thread::current
    }
  end

end
