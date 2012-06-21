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
    
    describe "user's reset password" do  
      it "GET 'reset page'" do
        get :forgot
        response.should have_selector("input", :id => 'user_email')
      end  
      
      it "POST 'reset page'" do
        User.should_receive(:find_by_email).with(@user.email)
        post :forgot, :user => {"email" => @user.email}
      end
      
      it "POST 'show notice'" do        
        post :forgot, :user => {}
        flash[:notice].should == I18n.t('helpers.notice_email')
      end
      
      it "POST 'render new session'" do        
        post :forgot, :user => {}
        response.should render_template('sessions/new')
      end
      
      it "POST 'reset password with reset code'" do
        @user.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )

        User.should_receive(:find_by_reset_code).with(@user.reset_code)
        post :reset_password, :reset_code => @user.reset_code
      end
      
      it "POST 'delete reset code'" do
        @attr = { :password => "newpassword", :password_confirmation => "newpassword" }
        @user.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        
        User.should_receive(:find_by_reset_code).with(@user.reset_code).and_return @user
        post :reset_password, :reset_code => @user.reset_code, :user => { :password => @attr[:password], :password_confirmation => @attr[:password_confirmation] }
        @user.reload
        @user.password.should == @attr[:password]
      end
      
     it "should have a flash message" do
        @attr = { :password => "newpassword", :password_confirmation => "newpassword" }
        @user.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        
        User.should_receive(:find_by_reset_code).with(@user.reset_code).and_return @user
        post :reset_password, :reset_code => @user.reset_code, :user => { :password => @attr[:password], :password_confirmation => @attr[:password_confirmation] }
        flash[:success].should == I18n.t('helpers.password_reset_successful')
      end
      
      it "should have a render NEW template" do
        @attr = { :password => "newpassword", :password_confirmation => "newpassword" }
        @user.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        
        User.should_receive(:find_by_reset_code).with(@user.reset_code).and_return @user
        post :reset_password, :reset_code => @user.reset_code, :user => { :password => @attr[:password], :password_confirmation => @attr[:password_confirmation] }
        response.should render_template('sessions/new')
      end
    end
    
  end
  
end
