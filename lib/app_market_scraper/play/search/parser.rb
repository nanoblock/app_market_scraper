module AppMarketScraper::Play::Search
  class Parser
    attr_reader :body

    def initialize(html_body)
      @body = html_body
    end

    def parse
      doc = Nokogiri::HTML(body)
      
      unless doc.css('.card').any?
        raise AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      apps = Array.new

      doc.css('.card').each do |response_html|
        begin
          app = AppMarketScraper::Play::App.new
          # parse(app, response_html)
          app.name = extract_name(response_html)
          app.developer = extract_developer(response_html)
          app.package = extract_package(response_html)
          app.stars = extract_stars(response_html)
          app.url = AppMarketScraper::GOOGLE_PLAY_BASE_URL + extract_url(response_html)
          app.image_url = extract_image_url(response_html)
          
        rescue
          raise AppMarketScraper::ParserError.new("Could not parse app store page")
          return
        ensure
          apps << app
        end
      end

      apps.each do |result|
        AppMarketScraper::Play::Detail::Scraper.new(result.package, result).start
      end

      
      # AppMarketScraper::Play::Detail::Parser.new().parse

      # print apps
    end

    private
    # def parse(app, response_html)
      
    # end

    def extract_url(response_html)
      Addressable::URI.parse(response_html.css('.card-content a.card-click-target').first['href'].strip)
      # id = uri.query_values['id']
    end

    def extract_package(response_html)
      Addressable::URI.parse(response_html.css('.card-content a.card-click-target').first['href'].strip).query_values['id']
    end

    def extract_name(response_html)
      response_html.css('.card-content .details a.title').first['title'].strip
    end

    def extract_developer(response_html)
      response_html.css('.card-content .details .subtitle-container .subtitle').first.content.strip
    end

    def extract_image_url(response_html)
      "https:" + response_html.css('.card-content .cover .cover-image-container .cover-outer-align .cover-inner-align img')
        .first['data-cover-large'].strip
    end

    def extract_stars(response_html)
      star = response_html.css('.card-content .reason-set .stars-container .reason-set-star-rating .tiny-star')
        .first['aria-label'].strip

      pattern_match_decimal(star).to_s
    end

    def pattern_match_decimal(string)
      string.match /(\d+[.]\d+)/
    end

  end
end