module SiteHelper

  def site
    site = Site.first
    site ? site : Site.new
  end
end
