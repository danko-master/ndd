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
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @main
      response.should be_success
    end   
  end
  
  
  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = {:title => "", :content => ""}
      end

      it "should render the main 'edit' page" do
        put :update, :id => @main, :main => @attr
        response.should render_template('edit')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :title => "New Main Page Title Update", :content => "New Main Page Content Update" }
      end

      it "should change the main page's attributes" do
        put :update, :id => @main, :main => @attr
        @main.reload
        @main.title.should == @attr[:title]
        @main.content.should == @attr[:content]
      end

      it "should redirect to the main page show page" do
        put :update, :id => @main, :main => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message on main page" do
        put :update, :id => @main, :main => @attr
        flash[:success].should == I18n.t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      end
    end
  end
  

end
