module PagesHelper  
  def all_menu_pages
    return Page.find(:all, :order => "order_id", :conditions => "ismenu = TRUE")
  end 
  
def display_tree_recursive(tree, parent_id)
  ret = "<ul>"
  tree.each do |node|
    if node.parent_id == parent_id
      ret += "<li>"
      ret += yield node
      ret += display_tree_recursive(tree, node.id) { |n| yield n }
      ret += "</li>"
    end
  end
  ret += "</ul>"
end
     
 
end
