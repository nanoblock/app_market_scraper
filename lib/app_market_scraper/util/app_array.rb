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
        array << element
      end
    end

    def reverse_each_with_index &block
      to_enum.with_index.reverse_each &block
    end

    def uniq(value)
      array.each do |element|
        return false if element.package == value
      end
      return true
    end

    def get
      array
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