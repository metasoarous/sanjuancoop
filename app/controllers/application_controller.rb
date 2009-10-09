# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require "aasm"

class ApplicationController < ActionController::Base
  # For some reason they put this in member's controller but instruct us to
  # place it here and delete the old include. Hmm - oh well, whatever works.
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
  
end
