class HBase
  class Cell
    attr_accessor :value, :timestamp
    
    def initialize value, timestamp
      @value, @timestamp = value, timestamp
    end
  end
end