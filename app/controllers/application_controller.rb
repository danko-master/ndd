class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  #for sessions
  #include SessionsHelper
  
  # Для меню
  include PagesHelper
  include MainsHelper
    
end
