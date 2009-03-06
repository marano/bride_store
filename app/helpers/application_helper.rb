# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title(title)
    content_for(:title) { title }
  end

  def title(head)
    content_for(:head) { head }
  end

end
