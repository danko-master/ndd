require 'spec_helper'

describe ArticlesController do
  
  render_views
  
    describe "GET 'show'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article) 
    end
    
    it "should be successful" do
      get :show, :id => @article
      response.should be_success
    end
    
    it "all pages in menu should be successful" do
        get :show, :id => @article
        assert_select "header nav ul li", {:minimum=>2}
    end    
  end
  
  describe "GET 'index'" do
    
         
   describe "for non-signed-in users" do
     
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
      31.times { Factory(:article) } 
    end
     
      it "should deny delete button" do
        get :index
        response.should_not have_selector("a",
                                        :"data-method" => "delete",
                                        :href => article_path(@article))
     end
      
     it "should deny edit button" do
        get :index
        response.should_not have_selector("a",
                                        :href => edit_article_path(@article))
     end
      
      
     it "should show selector of pagination" do
        get :index
        response.should have_selector("a",
                                        :href => "/articles?page=2")
     end
     
     it "should show DIV selector of pagination" do
        get :index
        response.should have_selector('div', :class => 'pagination')
     end
      
    end
    
   describe "for signed-in users" do
    
    before(:each) do
        @main = Factory(:main)
        @page = Factory(:page)
        @article = Factory(:article)
        31.times { Factory(:article) } 
        
        @user = test_sign_in(Factory(:user))
      end
     

    
     it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should show selector of pagination" do
        get :index
        response.should have_selector("a",
                                        :href => "/articles?page=2")
     end
     
     it "should show DIV selector of pagination" do
        get :index
        response.should have_selector('div', :class => 'pagination')
     end
      
    end
    
    
   
          
  end
  
  
  describe "GET 'new'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
      
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
      @article = Factory(:article)
      
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :date => "", :description => "", :fulltext => ""}
      end

      it "should not create an article" do
        lambda do
          post :create, :article => @attr
        end.should_not change(Article, :count)
      end

     
      it "should render the 'new' page" do
        post :create, :article => @attr
        response.should render_template('new')
      end
    end
  end
  

  describe "GET 'edit'" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
      
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @article
      response.should be_success
    end
  end
  
  
 describe "GET 'edit' for non-signed users" do
    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
    end

    it "should deny access to 'edit'" do
      get :edit, :id => @article
      response.should redirect_to(root_path)
    end
  end
  
  
  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :date => "", :description => "", :fulltext => ""}
      end

      it "should render the 'edit' article" do
        put :update, :id => @article, :article => @attr
        response.should render_template('edit')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New article", :date => Date.today, :description => "New description", :fulltext => "New text" }
      end

      it "should change the page's attributes" do
        put :update, :id => @article, :article => @attr
        @article.reload
        @article.name.should == @attr[:name]
        @article.date.should == @attr[:date]
        @article.description.should == @attr[:description]
        @article.fulltext.should == @attr[:fulltext]
      end

      it "should redirect to the page show page" do
        put :update, :id => @article, :article => @attr
        response.should redirect_to(article_path(@article))
      end

      it "should have a flash message" do
        put :update, :id => @article, :article => @attr
        flash[:success].should == I18n.t('activerecord.errors.controllers.message.attributes.page.page_update_success')
      end
    end
  end
  
  
 describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
      @article = Factory(:article)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @article
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        test_sign_in(@user)
      end

      it "should destroy the page" do
       lambda do
          delete :destroy, :id => @article
        end.should change(Article, :count).by(-1)
      end

      it "should redirect to the pages page" do
        delete :destroy, :id => @article
        response.should redirect_to(articles_path)
      end
      
      
      it "should show delete link" do
          get :index
          response.should have_selector("a",
                                        :"data-method" => "delete",
                                        :href => article_path(@article))
      end
      
    end
  end
 

end
