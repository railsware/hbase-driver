require 'hbase'
require 'spec_helper'

describe "HBase", :slow => true do
  before :all do
    begin
      @hbase = HBase.new(spec_config['url'])
    rescue Exception => e
      puts "Can't connect to HBase Stargate it's probably not started (#{spec_config['url']})!"
      raise e
    end    
    
    @hbase.delete 'users' if @hbase.include? "users"
    @hbase.create 'users', 'attr'
  end
  
  after :all do
    @hbase.delete 'users' if @hbase.include? "users"
  end

  it "metadata" do
    @hbase.all.find{|t| t.name == 'users'}.should_not be_nil
    @hbase['users'].metadata.name.should == 'users'
  end
  
  it "CRUD" do
    table = @hbase['users']
    table.should_not include('john')    
    
    # read
    table['john'].should be_nil
    
    # create
    timestamp = Time.now.to_i
    table.update 'john', 'attr:email' => 'john@mail.com', :timestamp => timestamp
    
    # read
    record = table['john']
    record['attr:email'].should == "john@mail.com"    
    record.cells['attr:email'].timestamp.should_not be_nil
    
    # update
    table.update 'john', 'attr:email' => "another@mail.com"
    # 
    # TODO add ability also update via record: 
    # record['attr:email'] = "another@mail.com"
    # record['attr:email'] = "another@mail.com", timestamp
    #     
    record = table['john']
    record['attr:email'].should == "another@mail.com"
    
    # delete
    table.delete 'john'    
    table.should_not include('john')
  end
  
  describe "scanner" do
    before :all do
      @users = @hbase['users']           
      
      @users.update 'john', 'attr:email' => 'john@mail.com'
      @users.update 'mario', 'attr:email' => 'mario@mail.com'
      @users.update 'stanley', 'attr:email' => 'stanley@mail.com'
    end
    
    it "scanner" do
      records = @users.scan :start => 'john', :batch => 5, :columns => ['attr:']
      records.collect{|record| record['attr:email']}.should == %w(john@mail.com mario@mail.com stanley@mail.com)
    end
  end
end