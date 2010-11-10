class HBase
  class Table
    attr_reader :stargate, :table_name
    
    def initialize(stargate, table_name)
      @stargate, @table_name = stargate, table_name
    end
    
    def get(key, with_timestamps = false)
      begin
        record = Record.new
        old_row = stargate.show_row(table_name, key)
        old_row.columns.each do |old_cell|
          record[old_cell.name] = Cell.new old_cell.value, old_cell.timestamp
        end
        record
      rescue Stargate::RowNotFoundError
        nil
      end
    end
    alias_method :[], :get
    
    def update(key, attributes)
      raise "ivalid usage, attributes should be a hash!" unless attributes.is_a? Hash
      timestamp = attributes.delete(:timestamp) || attributes.delete('timestamp') # || Time.now.to_i      
      attr_in_driver_format = attributes.to_a.collect do |attr_name, attr_value| 
        {:name => attr_name, :value => attr_value}
      end      
      stargate.create_row(table_name, key, timestamp, attr_in_driver_format)
    end
    alias_method :[]=, :update
    
    def delete(key)
      stargate.delete_row table_name, key      
    end
    
    def include?(key)
      !!get(key)      
    end
    alias_method :exist?, :include?
    
    def metadata
      stargate.show_table table_name
    end
    
    TRANSLATION = {
      :start => :start_row,
      :end => :end_row
    }
    def scan(options = {})
      options.symbolize_keys
      
      stargate_options = {}
      options.each do |k, v|
        stargate_options[TRANSLATION[k] || k] = v
      end
      
      scanner = stargate.open_scanner(table_name, stargate_options)
      begin
        old_rows = stargate.get_rows(scanner)
        records = []
        old_rows.each do |old_row|
          old_row.columns.each do |old_cell|
            record = Record.new
            record[old_cell.name] = Cell.new old_cell.value, old_cell.timestamp
            records << record
          end
        end
        records
      ensure
        stargate.close_scanner(scanner) if scanner
      end
    end
  end
end