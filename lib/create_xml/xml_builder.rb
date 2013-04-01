module CreateXml
  class XmlBuilder
    
    require 'builder'
    
    def initialize(file_name)
      @xml_file = File.new("./price_lists/#{file_name}", File::CREAT|File::RDWR)
      @xml = Builder::XmlMarkup.new(:target => @xml_file, :indent => 1)
      @xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
    end
    
    def build(list)
      @xml.Price_list do
   
        list.sections.each do |key, items|
          @xml.section do
            @xml.header(key)
            items.each do |item|
              @xml.item do
                @xml.style_number(item["Style Number"].strip)
                @xml.product_name(item["Product Seasonal Name"].strip)
                @xml.retail_price(item["Retail"].strip)
                @xml.pro_price(item["Pro"].strip)
              end
            end
          end
        end
      end
      
      @xml_file.close
      return @xml_file
      
    end
  end
end