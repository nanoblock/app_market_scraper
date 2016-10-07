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
      
      unless response_html.css('.browse-page').any?
        AppMarketScraper::ParserError.new('Could not parse app store page')
        return
      end

      @app = AppMarketScraper::Play::App.new
      packages = []
      response_html.css('.card .card-content').each do |response_html|
        begin
          packages << extract_package(response_html)
        rescue
          AppMarketScraper::ParserError.new("Could not parse app store page")
          return
        end
      end
      AppMarketScraper::Play.package.add_collection(packages)
      if AppMarketScraper.current_size == AppMarketScraper.app_limit
        AppMarketScraper::ParserError.new("#{AppMarketScraper.current_size} scraping google app success::Category")
        Thread::list.each {|t| Thread::kill(t) if t != Thread::current}
        return
      end
      packages
    end

    private
    def extract_package(response_html)
      response_html.css('@data-docid').last.text

      # .each do |package|
      #   packages << package.text.strip
      # end
      # packages
      # 
    end

  end
end