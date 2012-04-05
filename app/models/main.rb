class Main < ActiveRecord::Base
  attr_accessible :title, :metadescription, :metakeywords, :head, :content, :contact, :footer, :counter
  
   validates :title,
                :presence => true,
                :length => {:maximum => 200} 
                
   validates :content,
                :presence => true
end
