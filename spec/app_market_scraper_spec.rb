require 'spec_helper'
require 'csv'

describe AppMarketScraper do
  it 'has a version number' do
    expect(AppMarketScraper::VERSION).not_to be nil
  end

  it 'restart' do
    AppMarketScraper::AppMarketScraperLogger.new("@@@@@ Scrap Google App Start @@@@@\n")

    AppMarketScraper.app_limit = 112500
    AppMarketScraper.thread_limit = 200
    AppMarketScraper.backup_count = 200
    AppMarketScraper.csv_read_path = "../smta_play_ko_writer_back.csv"
    puts "path            -> #{AppMarketScraper.path}"
    puts "log_path        -> #{AppMarketScraper.log_path}"
    puts "csv_read_path   -> #{AppMarketScraper.csv_read_path}"
    puts "lang          -> #{AppMarketScraper.lang}"
    puts "country       -> #{AppMarketScraper.country}"


    AppMarketScraper.csv_reader(AppMarketScraper.csv_read_path)
    AppMarketScraper::Play::Category::Scraper.new(category: AppMarketScraper::Play.category, type: "multi").start

    while AppMarketScraper::Play.package.size > 1 do
      Parallel.each_with_index(AppMarketScraper::Play.package.array, in_threads: AppMarketScraper.thread_limit) { |package, index|
        if AppMarketScraper.current_size == AppMarketScraper.app_limit
          AppMarketScraper.thread_exit
          break
        end

        if AppMarketScraper.backup_count.include?(AppMarketScraper.current_size) && !AppMarketScraper.backup_count.nil?
          AppMarketScraper.csv_writer unless AppMarketScraper.current_size == 39800

        end
        AppMarketScraper::AppMarketScraperLogger.new("Item: #{package}, Worker: #{Parallel.worker_number}")
        AppMarketScraper::Play::Detail::Scraper.new(package, type: "multi").start
        AppMarketScraper::Play.package.array.delete_at(index)
      }
    end

  end

  it 'do SearchScraper class validator' do

  #   puts "@@@@@@@@@@@@@@@@@@@ Scrap Google App Start @@@@@@@@@@@@@@@@@@@"

  #   AppMarketScraper.app_limit = 112500
  #   AppMarketScraper.thread_limit = 50
  #   AppMarketScraper.backup_count = 500

  #   # AppMarketScraper::Play::Category::Scraper.new(
  #   #   category: AppMarketScraper::Play.categorys_find_by_key("health_and_fitness")).start
    
  #   Parallel.each(AppMarketScraper::Play.categorys.values, in_threads: AppMarketScraper::Play.categorys.size) {|item|
  #     puts "Item: #{item}, Thread Worker: #{Parallel.worker_number}"
  #     AppMarketScraper::Play::Category::Scraper.new(category: item, type: "multi").start
  #   }

  #   while AppMarketScraper::Play.package.size > 1 do

  #     Parallel.each_with_index(AppMarketScraper::Play.package.get, in_threads: AppMarketScraper.thread_limit) {|item, index|
  #       if AppMarketScraper.current_size == AppMarketScraper.app_limit
  #         AppMarketScraper.thread_exit
  #         break 0
  #       end

  #       if AppMarketScraper.backup_count.include?(AppMarketScraper.current_size) && !AppMarketScraper.backup_count.nil?
  #         AppMarketScraper.csv_writer
  #       end
  #       # puts "Item: #{item}, Worker: #{Parallel.worker_number}"
  #       AppMarketScraper::Play::Detail::Scraper.new(item, type: "multi").start
  #       AppMarketScraper::Play.package.get.delete_at(index)
  #     }
  #   end
  end


end
