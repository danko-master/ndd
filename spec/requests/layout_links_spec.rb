require 'spec_helper'

describe "LayoutLinks" do

  describe "when not signed in" do
    
   before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
    end
    
    it "should have a signin link" do
      visit root_path
      assert_select "header nav ul li", {:minimum=>2}
    end
  end


  describe "when signed in" do

    before(:each) do
      @main = Factory(:main)
      @page = Factory(:page)
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path)
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user))
    end
  end

end
