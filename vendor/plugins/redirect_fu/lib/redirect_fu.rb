module RedirectFu

  def render_redirect_to(to = '', params = {})
    @parameters = params
    @parameters[:to] = to
    render 'redirect/to', :layout => 'redirect'
  end
  
end
