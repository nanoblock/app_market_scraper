class AppMarketScraper::Play::Scraper
  require 'typhoeus'
  require 'addressable/uri'
  require 'net/http'
  require 'openssl'

  attr_reader :query
  attr_reader :country
  attr_reader :lang

  def initialize(query, opts={})
    @query = query
    @country = opts[:country] || AppMarketScraper::Play::DEFAULT_COUNTRY
    @lang = opts[:lang] || AppMarketScraper::Play::DEFAULT_LANG
    @request_opts = AppMarketScraper::Util.request_opts(opts)
  end

  def start
    req = Typhoeus::Request.new(build_uri, @request_opts)
    # puts req.url
    req.run
    response_handler(req.response)
  end

  def test
    begin
      uri = build_uri
      http = Net::HTTP.new(uri.host, 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      puts uri
      results = []
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
    rescue
      # @google_play_reachable = false
    ensure
      # p response.body

    end
  end

  private
  def build_uri
    uri = Addressable::URI.parse(set_url)
    # uri.query_values = @request_opts
    uri
  end

  def set_url
    uri = AppMarketScraper::GOOGLE_PLAY_BASE_URL
    uri << AppMarketScraper::GOOGLE_PLAY_SEARCH_URL
    uri << "?q=#{@query}" 
    uri << "&hl=#{@lang}"
    uri << "&gl=#{@country}"
    uri << "&c=#{AppMarketScraper::Play::CATEGORY}"
  end

  def response_handler(response)
    if response.success?
      # p response.body
      
      p "successed!!"
    else
      codes = "message=#{response.return_message}, code=#{response.code}, return_code=#{response.return_code}"
      case response.code
      when 404
        raise AppMarketScraper::NotFoundError.new("Unable to find app in store: #{codes}")
      when 403
        raise AppMarketScraper::UnavailableError.new("Unavailable app (country restriction?): #{codes}")
      else
        raise AppMarketScraper::ResponseError.new("Unhandled response: #{codes}")
      end
    end
  end

end