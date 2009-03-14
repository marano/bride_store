class String
  def canonical
    mb_chars.strip.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end
