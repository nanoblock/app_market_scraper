module AppMarketScraper::Play::Detail
  class Scraper
    attr_reader :package

    def initialize(package, app=nil, opts={})
      @package = package
      @app = app
      @request_opts = AppMarketScraper::Util::Network.request_opts(opts)
    end

    def start
      req = Typhoeus::Request.new(AppMarketScraper::Util::Network.build_uri(set_url), @request_opts)
      req.on_complete do |response|
        response_handler(req.response)
      end
      req.run
    end

    private
    def set_url
      uri = AppMarketScraper::GOOGLE_PLAY_DETAIL_URL
      uri += "?id=#{@package}"
      uri += "&hl=#{AppMarketScraper.lang}"
      uri += "&gl=#{AppMarketScraper.country}"
    end

    def response_handler(response)
      if response.success?
        AppMarketScraper::Play::Detail::Parser.new(response.body, @app).parse
      else
        AppMarketScraper::Util::Network.throw_exception(response)
      end
    end

  end
end