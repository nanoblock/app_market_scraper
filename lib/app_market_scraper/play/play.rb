module AppMarketScraper::Play
  
  def self.array
    @array ||= AppMarketScraper::Util::AppArray.new
  end

  def self.package
    @package ||= AppMarketScraper::Util::AppMarketScraperArray.new
  end

end