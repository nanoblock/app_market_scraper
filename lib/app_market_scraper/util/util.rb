module AppMarketScraper
  module Util
    SCRAPED_APP_COUNT = 0

    def self.play_scrap_counter
      @count ||= SCRAPED_APP_COUNT
      @count = @count.next
      puts "[#{Time.now}]  Google Apps scraping succeeded!!
      \tscraped app count   -> #{current_size}
      \tcurrent speed       -> #{current_speed} app/s
      \taver speed          -> #{aver_speed}"
    end

    def self.current_speed
      ((Time.now - AppMarketScraper.current_time) / @count).round(2)
    end

    def self.sum_speed(value)
      @speed_aver = (value.to_f + @speed_aver.to_f).round(2)
    end

    def self.aver_speed
      (sum_speed(current_speed) / current_size).round(2)
    end

    def self.current_size
      @count ||= AppMarketScraper::Play.result.size
    end

  end
end