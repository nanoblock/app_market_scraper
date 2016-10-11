module AppMarketScraper::Util
  class Network

    def self.timeout
      @timeout ||= 100
    end

    def self.timeout=(value)
      @timeout = value
    end

    def self.connect_timeout
      @connect_timeout ||= 100
    end

    def self.connect_timeout=(value)
      @connect_timeout = value
    end

    # github 주소 바꾸기
    def self.user_agent
      @user_agent ||= "AppMarketScraper/#{AppMarketScraper::VERSION} / " \
      "(+https://github.com/nanoblock/app_market_scraper)"
    end

    def self.user_agent=(value)
      @user_agent = value
    end

    def self.request_opts(opts={})
      opts[:timeout] ||= @timeout
      opts[:connecttimeout] ||= @connect_timeout
      opts[:ssl_verifypeer] = false
      opts[:ssl_verifyhost] = 2
      opts[:headers] ||= {}
      opts[:headers]['User-Agent'] ||= @user_agent
      # opts[:user_agent] ||= AppMarketScraper.user_agent
      opts
    end

    def self.build_uri(uri)
      uri = Addressable::URI.parse(uri)
      uri.normalize
    end

    def self.throw_exception(response)
      codes = "message=#{response.return_message}, code=#{response.code}, return_code=#{response.return_code}"
        case response.code
        when 404
          AppMarketScraper::NotFoundError.new("Unable to find app in store: #{codes}")
        when 403
          AppMarketScraper::UnavailableError.new("Unavailable app (country restriction?): #{codes}")
        when 0

        else
          AppMarketScraper::ResponseError.new("Unhandled response: #{codes}")
        end
    end

  end
end