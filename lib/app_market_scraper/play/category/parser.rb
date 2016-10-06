module AppMarketScraper::Play::Category
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
      response_html = Nokogiri::HTML(body)
      
      unless response_html.css('.card').any?
        AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      @app = AppMarketScraper::Play::App.new

      response_html.css('.card').each do |response_html|
        begin
          parse_search(response_html)

          if type == "base"
            return AppMarketScraper::Play::Detail::Scraper.new(@app.package, type: type).start
            # return @app
          else
            apps = Array.new
            apps << @app
            apps.each do |elements|
              AppMarketScraper::Play::Detail::Scraper.new(elements.package, type: type).start
            end
          end
        rescue
          AppMarketScraper::ParserError.new("Could not parse app store page")
          return
        end
      end
    end

  end
end