


class Page < ActiveRecord::Base
  
  attr_accessible :name, :title, :content, :metadescription, :metakeywords, :head, :ismenu
  
   validates :name,
                :presence => true,
                :length => {:maximum => 200} 
                
   validates :content,
                :presence => true
  

end
