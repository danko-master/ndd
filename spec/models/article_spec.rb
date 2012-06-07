require 'spec_helper'

describe Article do
  before(:each) do
    @attr = {
      :name => "Example Name 1",
      :date => "03.03.2008",
      :description => "Description 1",
      :fulltext => "Full content 1"
      }
    end
    
  it "Create a new instance given valid attributes" do
    Article.create!(@attr)
  end
  
  it "Require full text" do
    no_content = Article.new(@attr.merge(:fulltext => ""))
    no_content.should_not be_valid
  end
 
  it "Require Name" do
    no_name = Article.new(@attr.merge(:name => ""))
    no_name.should_not be_valid
  end
  
  it "Require Description" do
    no_name = Article.new(@attr.merge(:description => ""))
    no_name.should_not be_valid
  end
  
  it "Require Date" do
    no_name = Article.new(@attr.merge(:date => ""))
    no_name.should_not be_valid
  end
    
end
