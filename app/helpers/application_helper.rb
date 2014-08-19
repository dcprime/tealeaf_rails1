module ApplicationHelper
  
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end
  
  def display_datetime(dt)
    dt.strftime("%b %d, %Y at %r - %Z")
  end
  
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
end
