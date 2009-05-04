module MenuHelper

  def link_menu(label, actions)
    link_to_unless featured?(actions), label, first(actions)
  end
  
  private
  
  def featured?(actions)
    featured = false
    if actions.class == Array
      actions.each do |action|
        next if action.blank?
        featured = true if current_page? action 
      end
    else
      featured = current_page?(actions)
    end    
    return featured
  end
  
  def first(actions)
    actions.class == Array ? actions.first : actions
  end
  
end
