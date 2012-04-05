require 'spec_helper'

describe Page do
  
    before(:each) do
    @attr = {
      :name => "Example Name 1",
      :title => "Example 1",
      :content => "Content 1",
      :metadescription => "Meta Desc 1",
      :metakeywords => "Meta Key 1",
      :head => "Head 1"
      }
    end
      
  it "Create a new instance given valid attributes" do
    Page.create!(@attr)
  end
  

  it "Require Content" do
    no_content = Page.new(@attr.merge(:content => ""))
    no_content.should_not be_valid
 end
 
 it "Require Name" do
    no_name = Page.new(@attr.merge(:name => ""))
    no_name.should_not be_valid
 end
 
  
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

