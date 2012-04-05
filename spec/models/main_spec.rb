require 'spec_helper'

describe Main do
  
    before(:each) do
    @attr = {
      :title => "Example 1",
      :content => "Content 1",
      :metadescription => "Meta Desc 1",
      :metakeywords => "Meta Key 1",
      :head => "Head 1",
      :contact => "Contact 1",
      :footer => "Footer 1",
      :counter => "Counter 1"
      }
    end
      
  it "Create a new instance given valid attributes" do
    Main.create!(@attr)
  end
  
 it "Require Title" do
    no_title = Main.new(@attr.merge(:title => ""))
    no_title.should_not be_valid
 end
 
  it "Require Content" do
    no_content = Main.new(@attr.merge(:content => ""))
    no_content.should_not be_valid
 end
 
  
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

