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
      uri = AppMarketScraper::GOOGLE_PLAY_CATEGORY_URL
      uri += "/#{category}"
      unless family_range?
        uri += "?"
      end
      uri += "&hl=#{AppMarketScraper.lang}"
      uri += "&gl=#{AppMarketScraper.country}"
      uri
    end

    def response_handler(response)
      if response.success?
        AppMarketScraper::Play::Category::Parser.new(response.body, type: type).parse
        # if type == "base"
        #   
        # else

        #   AppMarketScraper::Play::Category::Parser.new(response.body, type: type).parse
        # end
          
      else
        AppMarketScraper::Util::Network.throw_exception(response)
      end
    end

    def family_range?

      if category == AppMarketScraper::Play.categorys[:family_age_range1] || category == AppMarketScraper::Play.categorys[:family_age_range2]|| category == AppMarketScraper::Play.categorys[:family_age_range3]
        return true
      end
      return false
    end
  end
end