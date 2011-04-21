class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_session

  def check_session
    if !session[:loggedin]
  	  redirect_to(:controller => 'pages', :action => 'login')
  	end
  end

end
