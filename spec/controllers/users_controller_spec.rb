require 'spec_helper'

describe UsersController do
  
 render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end   
  end
  
 describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
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
        @attr = { :email => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Name User", :email => "user@userexample.ru",
                  :password => "newpassword", :password_confirmation => "newpassword" }
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should == I18n.t('activerecord.errors.controllers.message.attributes.user.user_update_success')
      end
    end
  end
  
  describe "authentication of show/edit/update pages" do

    before(:each) do
      @user = Factory(:user)
      @main = Factory(:main)
      @page = Factory(:page)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'show'" do
        get :show, :id => @user
        response.should redirect_to(root_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end      
    end
  end
  
end
