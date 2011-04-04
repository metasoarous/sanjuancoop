# This controller handles the login/logout function of the site.	
class UserSessionsController < ApplicationController
	# render new.rhtml
	def new  
		@user_session = UserSession.new  
	end 

  def create
    user = User.authenticate(params[:login],params[:password])  
    if user  
    	session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(root_url)
    else  
    	note_failed_signin
      render :action => 'new'  
    end
  end  

  def destroy  
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end  

	protected
		# Track failed login attempts
		def note_failed_signin
			flash[:error] = "Couldn't log you in as '#{params[:login]}'"
			logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
		end
		
end
