module AppMarketScraper::Play::Search
  class Scraper
    attr_reader :query, :type

    def initialize(query, opts={})
      AppMarketScraper.current_time

      if opts[:type] == "multi"
        @type = opts[:type]
      else
        @type = "base"
      end
      opts.delete(:type)
      @query = query
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
      uri = AppMarketScraper::GOOGLE_PLAY_SEARCH_URL
      uri += "?q=#{@query}"
      uri += "&c=#{AppMarketScraper::Play::CATEGORY}"
      uri += "&hl=#{AppMarketScraper.lang}"
      uri += "&gl=#{AppMarketScraper.country}"
    end

    def response_handler(response)
      if response.success?
        AppMarketScraper::Play::Search::Parser.new(response.body, type: type).parse
      else
        AppMarketScraper::Util::Network.throw_exception(response)
      end
    end

  end
end