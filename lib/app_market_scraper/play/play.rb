module AppMarketScraper::Play
  
  def self.result
    # puts "come"
    @result ||= AppMarketScraper::Util::AppArray.new
  end

end