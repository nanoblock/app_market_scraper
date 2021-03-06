module AppMarketScraper::Play::Detail
  class Scraper
    attr_reader :package, :type

    def initialize(package, opts={})
      @package = package
      # @app = app
      if opts[:type] == "multi"
        @type = opts[:type]
      else
        @type = "base"
      end
      opts.delete(:type)
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
      uri = AppMarketScraper::GOOGLE_PLAY_DETAIL_URL
      uri += "?id=#{@package}"
      uri += "&hl=#{AppMarketScraper.lang}"
      uri += "&gl=#{AppMarketScraper.country}"
    end

    def response_handler(response)
      if response.success?
        if type == "base"
          AppMarketScraper::Play::Detail::Parser.new(response.body, type: type).parse
        else
          AppMarketScraper::Play::Detail::Parser.new(response.body, type: type).parse
        end
      else
        AppMarketScraper::Util::Network.throw_exception(response)
      end
    end

  end
end