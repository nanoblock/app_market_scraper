module AppMarketScraper::Play::Search
  class Parser
    attr_reader :body, :type

    def initialize(html_body, opts={})
      @body = html_body
      if opts[:type] == "multi"
        @type = opts[:type]
      else
        @type = "base"
      end

      opts.delete(:type)
    end

    def parse
      doc = Nokogiri::HTML(body)
      
      unless doc.css('.card').any?
        AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      
      @app = AppMarketScraper::Play::App.new

      doc.css('.card').each do |response_html|
        begin
          parse_search(doc)

          if type == "base"
            return AppMarketScraper::Play::Detail::Scraper.new(@app.package, type: type).start
            # return @app
          else
            apps = Array.new
            apps << @app
            apps.each do |elements|
              AppMarketScraper::Play::Detail::Scraper.new(elements.package, type: type).start
            end
            if AppMarketScraper.current_size == AppMarketScraper.app_limit

              # raise Parallel::Kill
              AppMarketScraper::ParserError.new("#{AppMarketScraper.current_size} scraping google app success::Search")
              Thread::list.each {|t| Thread::kill(t) if t != Thread::current}
              return
              # Thread.exit
            end
          end
        rescue
          AppMarketScraper::ParserError.new("Could not parse app store page")
          return
        end
      end
    end

    private
    def parse_search(response_html)
      @app.name ||= extract_name(response_html)
      @app.developer ||= extract_developer(response_html)
      @app.package ||= extract_package(response_html)
      @app.stars ||= extract_stars(response_html)
      @app.url ||= extract_url(response_html)
      @app.image_url ||= extract_image_url(response_html)
      
    end

    def extract_url(response_html)
      AppMarketScraper::GOOGLE_PLAY_DETAIL_URL + "?id=#{extract_package(response_html)}".strip
      # Addressable::URI.parse(response_html.css('.card-content a.card-click-target').first['href'].strip)
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
      # star = response_html.css('.card-content .reason-set .stars-container .reason-set-star-rating .tiny-star')
      #   .first['aria-label'].strip

      # pattern_match_decimal(star).to_s
       
      star = response_html.css('.tiny-star').first['aria-label']
      pattern_match_decimal(star).to_s
    end

    def pattern_match_decimal(string)
      string.match /(\d+[.]\d+)/
    end

  end
end