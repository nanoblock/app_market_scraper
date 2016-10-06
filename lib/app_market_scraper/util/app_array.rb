module AppMarketScraper::Util
  class AppArray < AppMarketScraperArray
    attr_reader :type, :array
    #default type is play
    def initialize(element=nil, type="play", opts={})
      @array ||= Array.new
      type_validator(type)
    end

    def add(element)
      if instance_of?(element)
        super
      end
    end

    private

    def type_validator(type)
      unless type == "play" || type == "apple"
        AppMarketScraper::ParamsError.new("invalidated this type!!")
        return
      end
      @type = type
    end

    def instance_of?(element)
      unless element.kind_of? AppMarketScraper::Play::App
        AppMarketScraper::ParamsError.new("invalidated this elements instance!!")
        return
      end
      return true
    end

  end
end