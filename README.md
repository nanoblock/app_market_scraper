# AppMarketScraper
[![language](https://img.shields.io/badge/language-ruby-coral.svg)](https://www.ruby-lang.org/en/)
![version](https://img.shields.io/badge/version-1.0.0-green.svg)
[![e-mail](https://img.shields.io/badge/email-taiyou88@naver.com-blue.svg)](mailto:taiyou88@naver.com)

Yongseok should scrap the company, information of the registered app on Google Play
## Install

```ruby
gem 'app_market_scraper'
```

## Usage

### Default Language & country
- DEFAULT_LANG = 'ko'
- DEFAULT_COUNTRY = 'ko'

```ruby
# You can also set the language & country settings
AppMarketScraper.lang = 'en'
AppMarketScraper.country = 'en'
```

###Default Config

```ruby
DEFAULT_THREAD_LIMIT = 100
DEFAULT_APP_LIMIT = 200
CURRENT_TIME = Time.now
DEFAULT_LOG_PATH = File.expand_path("../../../app_market_scraper.log", __FILE__)
DEFAULT_BASE_PATH = File.expand_path("../../../smta_play_ko_writer.csv", __FILE__)
```
### Global variable

```ruby
AppMarketScraper::Play.package
AppMarketScraper::Play.array
```

### Scrap Mode

You must set the type.<br>
You can set the mode of scrap type setting.<br>
type -> base or multi<br>
Default type is base<br>

```ruby
AppMarketScraper::Play::Detail::Scraper.new(package, type: "base").start
AppMarketScraper::Play::Detail::Scraper.new(package, type: "multi").start
```

### Parallel Execution

```ruby
# 100 Processes -> finished after 1 run
results = Parallel.map(['a','b','c'], in_processes: 100) { |array_item| ... }

# 100 Threads -> finished after 1 run
results = Parallel.each(['d','e','f'], in_threads: 100) { |array_item| ... }
```

### Sample code

```ruby
result_app = AppMarketScraper::Play::App.new
result_app = AppMarketScraper::Play::Detail::Scraper.new(package, type: "base").start
```

### Running parallel sample code

```ruby
Parallel.each_with_index(target_array, in_threads: AppMarketScraper.thread_limit) { |package, index|
  if AppMarketScraper.current_size == AppMarketScraper.app_limit
    AppMarketScraper.thread_exit
    break
  end

  if AppMarketScraper.backup_count.include?(AppMarketScraper.current_size) && !AppMarketScraper.backup_count.nil?
    AppMarketScraper.csv_writer unless AppMarketScraper.current_size == 0
  end

  AppMarketScraper::Play::Detail::Scraper.new(package, type: "multi").start
  AppMarketScraper::Play.package.array.delete_at(index)
}
```

## TIP
When writing a csv file, should not end the program.<br>
You should check the status of the csv writer before exiting the program.

```ruby
# When the program starts writing the CSV file, returns true
AppMarketScraper.backup_start?
```
<!-- ## Contributing -->

<!-- Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/app_market_scraper. -->


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

