%w(
  support
  cell
  record
  table
  hbase
).each{|f| require "hbase/#{f}"}

require 'stargate'