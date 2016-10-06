module AppMarketScraper::Play::Category
  class Scraper
    attr_reader :type, :category

    def initialize(opts={})
      if opts[:type] == "multi"
        @type = opts[:type]
      else
        @type = "base"
      end
      unless opts[:category].nil?
        @category = opts[:category]
      else
        @category = AppMarketScraper::Play.category
      end

      opts.delete(:type)
      opts.delete(:category)
      @request_opts = AppMarketScraper::Util::Network.request_opts(opts)
    end

    def start
      req = Typhoeus::Request.new(AppMarketScraper::Util::Network.build_uri(set_url), @request_opts)
      req.on_complete do |response|
        return response_handler(req.response)
      end
      req.run
    end

    private
    def set_url
      if @type == AppMarketScraper::Play.category
        return AppMarketScraper::GOOGLE_PLAY_CATEGORY_APPS_URL
      end
      
      uri = AppMarketScraper::GOOGLE_PLAY_CATEGORY_URL
      uri += "/#{category}"
      uri += "?&hl=#{AppMarketScraper.lang}"
      uri += "&gl=#{AppMarketScraper.country}"
    end

    def response_handler(response)
      if response.success?
        if type == "base"
          # AppMarketScraper::Play::Detail::Parser.new(response.body, type: type).parse
        else
          # AppMarketScraper::Play::Detail::Parser.new(response.body, type: type).parse
        end
      else
        AppMarketScraper::Util::Network.throw_exception(response)
      end
    end
  end
end