require 'spec_helper'

describe AppMarketScraper do
  it 'has a version number' do
    expect(AppMarketScraper::VERSION).not_to be nil
  end

  it 'do SearchScraper class validator' do
    # AppMarketScraper::Play::Search::Scraper.new('facebook').start
    # AppMarketScraper::Play.result.elements.each do |value|
    #   p value.url
    # end
  end

  it 'do DetailScraper class validator' do
    AppMarketScraper::Play::Detail::Scraper.new('com.facebook.moments').start
    AppMarketScraper::Play.result.elements.each do |value|
      p value.name
      p value.email
      p value.category
      p value.developer
      p value.package
      p value.stars
      p value.download
      p value.updated
      p value.content_rating
      p value.version
      p value.operating_system
      p value.address
      p value.url
      p value.image_url
      p value.developer_web_site
    end
    
  end

  it 'do AppArray class validator' do
    # expect(AppMarketScraper::Util::AppArray.new.type ).to eq "play"
    # app = AppMarketScraper::Play::App.new
    # array = [AppMarketScraper::Play::App.new, AppMarketScraper::Play::App.new, AppMarketScraper::Play::App.new]
    # expect(AppMarketScraper::Util::AppArray.new(app).add_collection(array).delete_all.size ).not_to eq nil
  end

end
