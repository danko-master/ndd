require 'spec_helper'

describe MainsController do

  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end
    
    it "should be successful" do
      get :show, :id => @main
      response.should be_success
    end
    
    it "all pages in menu should be successful" do
        get :show, :id => @main
        assert_select "header nav ul li", {:minimum=>2}
    end
    
  end

  describe "GET 'edit'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end

    it "should be successful" do
      get :edit, :id => @main
      response.should be_success
    end
    
   
  end

end
