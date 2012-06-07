class Article < ActiveRecord::Base
  
  attr_accessible :name, :date, :fulltext, :description
  
   validates :name,
                :presence => true,
                :length => {:maximum => 200}
                
  validates :date,
                :presence => true
 
   validates :fulltext,
                :presence => true
                
   validates :description,
                :presence => true
  
  
end
