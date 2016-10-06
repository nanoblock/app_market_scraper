module AppMarketScraper::Play
  
  def self.result
    # puts "come"
    @result ||= AppMarketScraper::Util::AppArray.new
  end

  def self.array
    @array ||= AppMarketScraper::Util::AppMarketScraperArray.new
  end

end