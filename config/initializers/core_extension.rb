class String
  def canonical
    mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
  
  def trim
    gsub(/ /,'')
  end
end

class ActiveRecord::Base
  def helpers
    ActionController::Base.helpers
  end
end
