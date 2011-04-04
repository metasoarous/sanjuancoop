# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout :determined_by_response
  
  helper_method :admin?, :logged_in?, :current_user_session, :current_user
  
  protected
  
		def current_user_session
			return @current_user_session if defined?(@current_user_session)
			@current_user_session = UserSession.find
		end

		def current_user
			return @current_user if defined?(@current_user)
			@current_user = current_user_session && current_user_session.user
		end
		
		# gives access only to admins
		def admin_authorize
		  unless admin?
		    unauthorized_access
		  end
		end
		
		# gives access only to site users who are logged in
		def logged_in_authorize
		  unless logged_in?
		    unauthorized_access
		  end
		end
		
		# gives access only to the a specific user or admin -
		# helpfull for making sure that users can get at their own data
		def owner_authorize(user_id)
		  unless logged_in? and (current_user.id == user_id or admin?)
		    unauthorized_access
		  end
		end
		
		# handles any unauthorized access
		def unauthorized_access
		  flash[:notice] = "Unauthorized access"
		  redirect_to "/"
		  return false
		end
		
		def determined_by_response
		  if request.xhr?
		    return false
		  else
		    "application"
		  end
		end
		
		def admin?
		  if current_user
		    return current_user.admin? 
		  else
		    return false
		  end
		end
		
		def logged_in?
		  current_user
		end
		
		# This sets up method which allows controllers to either assign a user_id param to 
		# a specific user_id or to current_user.id if none is supplied
		# using a merge method on the param hash. Returns the hash that gets fed
		# into the create method. Helps tests not fuck up...
		def userified_params(object)
		  entry_params = params[object.to_sym]
		  if current_user
		    entry_params = {:user_id => current_user.id}.merge(entry_params) 
		  end
		end
end
