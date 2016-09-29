require 'spec_helper'

describe AppMarketScraper do
  it 'has a version number' do
    expect(AppMarketScraper::VERSION).not_to be nil
  end

  it 'do scraper initialize' do
    # expect(AppMarketScraper::Play::App.new('test').query).to eq 'test'
    expect(AppMarketScraper::Play::Scraper.new('facebook').start).not_to eq nil
    
  end

end
