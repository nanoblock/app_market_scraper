module AppMarketScraper::Util
  class AppMarketScraperArray < Array
    attr_reader :array

    def initialize(element=nil)
      @array ||= Array.new
    end

    def add(element)
      if params_check(element)
        AppMarketScraper.mutex.synchronize do
          array << element
        end
      end
      self
    end

    def add_collection(value)
      if params_check(value)
        AppMarketScraper.mutex.synchronize do
          array.concat value
          array.flatten!
          array.compact!
          array.uniq!
        end
      end
      self
    end

    def pop
      unless array.empty?
        result = array.get(0)
        array.delete(0)
        return result
      else
        AppMarketScraper::AppMarketScraperArrayError.new("Elements is null")
      end
    end

    def uniq
      array.uniq!
      array
    end

    def last
      array.last
    end

    def get(value)
      if params_check(value) && !array.empty? && value.kind_of?(Integer)
        return result = array[value]
      end
    end

    def size
      array.length
    end

    def clear
      array.clear
    end

    def delete_all
      "come"
      self.clear
    end

    def delete(element)
      value = get(element)
      array.delete_at(element) { AppMarketScraper::NotFoundError.new("FAIL DELETE - Elements Not Found") }
      self
    end

    def find_package(package)
      array.each do |value|
        if package == value
          return false
        else
          return true
        end
      end
    end

    private
    def params_check(param)
      if param.nil?
        AppMarketScraper::ParamsError.new("Parameter is null")
        return false
      end
      return true
    end

  end
end