module PagesHelper  
  def all_menu_pages
    return Page.find(:all, :order => "name", :conditions => "ismenu = TRUE")
  end 
end
