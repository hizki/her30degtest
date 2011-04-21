class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_session

  def check_session
    if !session[:loggedin]
  	  redirect_to(:controller => 'pages', :action => 'login')
  	end
  end
  
  def sem2int(sem)
    if sem == "Winter"
      1
    elsif sem == "Spring"
      2
    else
      3
    end
  end
end
