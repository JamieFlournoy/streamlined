require 'csv'

module Enumerable
  def to_streamlined_csv(keys, options = {:header=>true, :separator => ','})
    str = ''
    header = options.delete(:header)
    header = keys if header == true
    ::CSV::Writer.generate(str, options[:separator]) do |csv|
      csv << header if header
      each do |item|
        csv << keys.inject([]) {|coll,key| coll << item.send(key); coll}
      end
    end 
    str
  end
  alias_method :to_csv, :to_streamlined_csv # preserve existing API for people not using FasterCSV
end