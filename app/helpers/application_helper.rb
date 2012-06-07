module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => main_page_data.title, :title => main_page_data.title)
  end
end
