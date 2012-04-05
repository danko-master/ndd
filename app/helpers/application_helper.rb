module ApplicationHelper
  def logo
    image_tag("rails.png", :alt => "Sample App", :class => "round")
  end
end
