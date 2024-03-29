require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "ExampleUser",
      :email => "usermail@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
      }
    
    @attr2 = {:name => "ExampleUser2", :email => "usermail2@example.com"}
  end  

  it "Create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "Require User name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "Require email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "Very long names" do
    long_name = "a"*51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
    
  end
  
  it "Accept valid email addresses" do
    
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
  end
    
  end
  
  it "Reject invalid email addresses" do
    
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
    
  end
  
  it "Reject duplicate email" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:name => @attr2[:name]))
    user_with_duplicate_email.should_not be_valid
  end
  
  it "Reject email idential up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_upcase_email = User.new(@attr.merge(:name => @attr2[:name]))
    user_with_upcase_email.should_not be_valid    
  end
  
  it "Reject duplicate name" do
    User.create!(@attr)
    user_with_duplicate_name = User.new(@attr.merge(:email => @attr2[:email]))
    user_with_duplicate_name.should_not be_valid
  end
  
  it "Reject name idential up to case" do
    upcased_email = @attr[:name].upcase
    User.create!(@attr.merge(:name => upcased_email))
    user_with_upcase_name = User.new(@attr.merge(:email => @attr2[:email]))
    user_with_upcase_name.should_not be_valid 
  end
  
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => ""))
      should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid"))
        should_not be_valid
    end
    
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    
    
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
      
    end
    
    
    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
      
    end
    
    
  end
  
  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should be an admin by default" do
      @user.should be_admin
    end

  end
  
  describe "reset password" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should create reset code" do           
      @user.create_reset_code
      @user.reset_code.should_not be_nil
    end    
    
    it "should send reset code by email" do           
      @user.create_reset_code
            
      @email_confirmation = ActionMailer::Base.deliveries.last
      @email_confirmation.to.should == [@user.email] 
      @email_confirmation.subject.should == I18n.t('emailer.pass_reset.subject')
      @email_confirmation.html_part.body.should match /#{@user.reset_code}/
    end 
    
    it "should delete reset code" do           
      @user.delete_reset_code
      @user.reset_code.should be_nil
    end
  end

end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  admin              :boolean         default(TRUE)
#

