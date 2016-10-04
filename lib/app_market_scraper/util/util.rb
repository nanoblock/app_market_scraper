module AppMarketScraper
  module Util
    SCRAPED_APP_COUNT = 0

    def self.play_scrap_counter
      @count ||= SCRAPED_APP_COUNT
      @count = @count.next
      puts "[#{Time.now}]  Google Apps scraping succeeded!!  SCRAPED_APP_COUNT : #{AppMarketScraper::Play.result.size}"
    end

  end
end