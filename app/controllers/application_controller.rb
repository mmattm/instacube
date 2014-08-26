class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :is_active?

  SUPER_SECRET_TOKEN = "351244118.1515381.eebfac413392427ca88ce9fdf65db00e"
  

  

  private
  def is_active?(page_name)
    if params[:controller] != 'welcome'
    "active" if params[:action] == page_name
    end
  end

  def current_user
  	#puts "SESSION : "
  #	puts session[:user_id]

    @current_user ||= User.find(session[:user_id]['$oid']) if session[:user_id]

  end
end
