class HBase
  class Record
    attr_reader :cells
    
    def initialize
      @cells = {}
    end
    
    def get(key)
      if cell = cells[key]
        cell.value
      else
        nil
      end
    end
    alias_method :[], :get
    
    def size
      cells.size
    end
  end
end