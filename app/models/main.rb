class Main < ActiveRecord::Base
  attr_accessible :title, :metadescription, :metakeywords, :head, :content, :contact, :footer, :counter
  
   validates :title,
                :presence => true,
                :length => {:maximum => 200} 
                
   validates :content,
                :presence => true
end
# == Schema Information
#
# Table name: mains
#
#  id              :integer         not null, primary key
#  title           :string(255)     default("Empty string"), not null
#  content         :text            default("Empty string"), not null
#  metadescription :text            default(""), not null
#  metakeywords    :text            default(""), not null
#  head            :text            default(""), not null
#  contact         :text            default(""), not null
#  footer          :text            default(""), not null
#  counter         :text            default(""), not null
#  created_at      :datetime
#  updated_at      :datetime
#

