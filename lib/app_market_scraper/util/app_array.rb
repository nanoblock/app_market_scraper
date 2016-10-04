module AppMarketScraper::Util
  class AppArray
    attr_reader :type, :elements

    def initialize(element=nil, type="play", opts={})
      @elements = Array.new
      type_validator(type)
      @mutex = AppMarketScraper.mutex
      # add(element)
    end

    def add(element)
      params_check(element)

      if instance_of?(element)
        @mutex.synchronize do
          @elements << element
        end
      end
      self
    end

    def add_collection(value)
      params_check(value)
      @mutex.synchronize do
        elements.concat value
        elements.compact!
        elements.uniq
      end
      self
    end

    def last
      elements.last
    end

    def get(element)
      params_check(element)

      if element.kind_of? Integer
        result = elements[element]
      end

      elements.each do |value|
        if value == element
          result = value
        end
      end

      unless result.nil?
        return result
      else
        raise AppMarketScraper::NotFoundError.new("FAIL Get - Element Not Found")
        return
      end

    end

    def size
      elements.length
    end

    def clear
      elements.clear
    end

    def delete_all
      self.clear
    end

    def delete(element)
      value = get(element)
      elements.delete(value) { raise AppMarketScraper::NotFoundError.new("FAIL DELETE - Elements Not Found") }
      self
    end

    private

    def type_validator(type)
      unless type == "play" || type == "apple"
        raise AppMarketScraper::ParamsError.new("invalidated this type!!")
        return
      end
      @type = type
    end

    def instance_of?(element)
      unless element.kind_of? AppMarketScraper::Play::App
        raise AppMarketScraper::ParamsError.new("invalidated this elements instance!!")
        return
      end
      return true
    end

    def params_check(param)
      if param.nil?
        raise AppMarketScraper::ParamsError.new("Parameter is null")
        return
      end
    end

  end
end