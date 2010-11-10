class HBase
  attr_reader :stargate
  
  def initialize *args
    @stargate = Stargate::Client.new *args
  end
  
  def get table_name
    HBase::Table.new stargate, table_name
  end
  alias_method :[], :get
    
  def delete table_name
    stargate.delete_table table_name
  end

  def truncate table_name
    stargate.truncate table_name
  end

  def all      
    stargate.list_tables
  end
  alias_method :list, :all
  
  def include? table_name
    all.any?{|meta| meta.name == table_name}
  end
  alias_method :exist?, :include?
  
  def create *args
    stargate.create_table *args
  end
  
  def disable *args
    stargate.disable_table *args
  end
  
  def enable *args
    stargate.enable_table *args
  end
end