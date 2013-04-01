module CreateXml
  
  class PriceList
    
     require 'csv'
     
     attr_reader :sections
     
     def initialize(csv_file)
      
      @sections = Hash.new
       
      csv_data = CSV.read(csv_file)
      headers = csv_data.shift.map {|i| i.to_s }
      string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
      rows = string_data.map {|row| Hash[*headers.zip(row).flatten] }
      
      create_section_hash(rows)
      
     
     end
     
    def create_section_hash(rows)
      
      rows.each do |row|
        unless @sections.has_key?(row["Team"])
          items = Array.new
          @sections[row["Team"]] = items
        end
        
        @sections[row["Team"]] << row
        
      end
    end
     
  end
end