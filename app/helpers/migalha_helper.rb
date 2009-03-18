module MigalhaHelper

  def migalha(text)
    content = ['::', link_to('home', home_path)]
    
    if text.class == Array
      content.concat text
    else
      content << text.to_s
    end
    
    put_content(make_items(content))
  end
  
  def make_items(text)
    items = format(text.delete_at 0)
    for m in text
      items += make_item(m)
    end
    items
  end
  
  def put_content(content)
    content_for :migalha do
      content
    end
  end
  
  def format(text)
    "<li>#{text}</li>"
  end
  
  def make_item(text)
    migalha_separator + format(text.downcase)
  end
  
  def migalha_separator
    format(' / ')
  end
  
  def migalha_current_list(text)
    list = []
    
    unless current_list.nil?
      list << link_to('minha conta', account_path) << current_list.name.downcase
    end
    
    if text.class == Array
      list.concat(text)
    else
      list << text
    end
    
    migalha list
  end
  
  def migalha_current_store(text)
    list = []
    
    unless current_store.nil?
      list << link_to(current_store.title.downcase, store_path(current_store.adress))
    end
    
    if text.class == Array
      list.concat(text)
    else
      list << text
    end
    
    migalha list
  end
  
end
