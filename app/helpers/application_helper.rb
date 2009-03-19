# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title(content)
    content_for(:title) { content }
  end

  def head(content)
    content_for(:head) { content }
  end

  def mark(value)
    image_tag (value ? 'check.gif' : 'uncheck.gif')
  end

  def mark_if(value)
    mark(value) if value
  end

end
