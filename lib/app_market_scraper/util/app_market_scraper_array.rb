module AppMarketScraper::Util
  class AppMarketScraperArray
    attr_reader :elements

    def initialize(element=nil)
      @elements ||= Array.new
    end

    def add(element)
      params_check(element)

      AppMarketScraper.mutex.synchronize do
          elements << element
      end
      self
    end

    def add_collection(value)
      params_check(value)
      
      AppMarketScraper.mutex.synchronize do
        elements.concat value
        elements.flatten!
        elements.compact!
        elements.uniq!
      end
      self
    end

    def uniq
      elements.uniq!
      elements
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
    def find_package(package)
      elements.each do |value|
        if package == value
          # puts "same"
          return false
        else
          # puts "not same"
          return true
        end

      end
    end
    private
    def params_check(param)
      if param.nil?
        raise AppMarketScraper::ParamsError.new("Parameter is null")
        return
      end
    end

  end
end