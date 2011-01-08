class HBase
  class Record
    attr_reader :cells
    attr_accessor :id
    
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
    
    def to_hash(with_id = false)
      hash = {}
      hash['id'] = id if with_id and id and !id.empty?
      cells.each do |k, v|
        hash[k.sub(/^[^:]*:/, '')] = v.value
      end
      hash
    end
    alias_method :to_h, :to_hash
  end
end