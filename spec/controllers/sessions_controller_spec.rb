require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do    
   before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end

    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    describe "invalid signin" do

      before(:each) do
       @main = Factory(:main)
       @page = Factory(:page)
       @attr = { :email => "email@example.example", :password => "invalid" }
      end
      
      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should_not be_nil
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
    end
    
    describe "with valid email and password" do

      before(:each) do
        @main = Factory(:main)
        @page = Factory(:page)
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end   
  end
  
   describe "DELETE 'destroy'" do

      it "should sign a user out" do
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end
    end 
  
end
