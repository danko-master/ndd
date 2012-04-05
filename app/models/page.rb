


class Page < ActiveRecord::Base
  
  attr_accessible :name, :title, :content, :metadescription, :metakeywords, :head, :ismenu
  
   validates :name,
                :presence => true,
                :length => {:maximum => 200} 
                
   validates :content,
                :presence => true
  

end
# == Schema Information
#
# Table name: pages
#
#  id              :integer         not null, primary key
#  name            :string(255)     default("Empty string")
#  title           :string(255)     default("Empty string")
#  metadescription :text            default("")
#  metakeywords    :text            default("")
#  head            :text            default("")
#  content         :text            default("Empty string")
#  ismenu          :boolean         default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

