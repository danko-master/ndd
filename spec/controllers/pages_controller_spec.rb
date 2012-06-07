require 'spec_helper'

describe PagesController do
  
  render_views

  describe "GET 'show'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end
    
    it "should be successful" do
      get :show, :id => @page
      response.should be_success
    end
    
    it "all pages in menu should be successful" do
        get :show, :id => @page
        assert_select "header nav ul li", {:minimum=>2}
    end   
    
       
   it "show sub pages" do        
       @pagechild = Factory(:page)
       @pagechild[:parent_id] = @page.id
       
       get :show, :id => @page
       response.should have_selector("a",
                                        :href => page_path(@pagechild))
    end    
  end
  
  describe "GET 'index'" do
    
         
   describe "for non-signed-in users" do
     
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end
     
      it "should deny access" do
        get :index
        response.should redirect_to(root_path)
      end
    end
    
   describe "for signed-in users" do
    
    before(:each) do
        @main = Factory(:main)
        @page = Factory(:page)
        
        @user = test_sign_in(Factory(:user))
      end
     

    
     it "should be successful" do
        first = Factory(:page, :name => "First page", :title => "First page title", :content => "First page content")
        second  = Factory(:page, :name => "Second page", :title => "Second page title", :content => "Second page content")

       
        @pages = [first, second]
        get :index
        response.should be_success
      end
    end
    
    
   
          
  end
  
  
  describe "GET 'new'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  
   describe "POST 'create'" do
     
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :title => "", :content => ""}
      end

      it "should not create a page" do
        lambda do
          post :create, :page => @attr
        end.should_not change(Page, :count)
      end

     
      it "should render the 'new' page" do
        post :create, :page => @attr
        response.should render_template('new')
      end
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
      get :edit, :id => @page
      response.should be_success
    end
  end
  
  
 describe "GET 'edit' for non-signed users" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end

    it "should deny access to 'edit'" do
      get :edit, :id => @page
      response.should redirect_to(root_path)
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
        @attr = { :name => "", :title => "", :content => ""}
      end

      it "should render the 'edit' page" do
        put :update, :id => @page, :page => @attr
        response.should render_template('edit')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Page Update", :title => "New Page Title Update", :content => "New Page Content Update" }
      end

      it "should change the page's attributes" do
        put :update, :id => @page, :page => @attr
        @page.reload
        @page.name.should == @attr[:name]
        @page.title.should == @attr[:title]
        @page.content.should == @attr[:content]
      end

      it "should redirect to the page show page" do
        put :update, :id => @page, :page => @attr
        response.should redirect_to(page_path(@page))
      end

      it "should have a flash message" do
        put :update, :id => @page, :page => @attr
        flash[:success].should == I18n.t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      end
    end
  end
  
  
 describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @page
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        test_sign_in(@user)
      end

      it "should destroy the page" do
       lambda do
          delete :destroy, :id => @page
        end.should change(Page, :count).by(-1)
      end

      it "should redirect to the pages page" do
        delete :destroy, :id => @page
        response.should redirect_to(pages_path)
      end
      
      it "should remove parent_id from children" do    
       @pagechild = Factory(:page)
       @pagechild[:parent_id] = @page.id
      
       delete :destroy, :id => @page
       @pagechild.reload.parent_id.should == -1
      end
      
      it "should show delete link" do
          get :index
          response.should have_selector("a",
                                        :"data-method" => "delete",
                                        :href => page_path(@page))
      end
      
    end
  end
  

end
