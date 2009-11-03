# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout :determined_by_response
  
  helper_method :admin?, :logged_in?

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  protected
  
  def determined_by_response
    if request.xhr?
      return false
    else
      "application"
    end
  end
  
  def admin?
    if current_member
      return current_member.admin? 
    else
      return false
    end
  end
  
  def logged_in?
    current_member
  end
  
  # This sets up method which allows controllers to either assign a member_id param to 
  # a specific member_id or to current_member.id if none is supplied
  # using a merge method on the param hash. Returns the hash that gets fed
  # into the create method. Helps tests not fuck up...
  def memberified_params(object)
    entry_params = params[object.to_sym]
    if current_member
      entry_params = {:member_id => current_member.id}.merge(entry_params) 
    end
  end
end
