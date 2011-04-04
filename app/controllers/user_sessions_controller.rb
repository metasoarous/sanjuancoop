# This controller handles the login/logout function of the site.	
class UserSessionsController < ApplicationController
	# render new.rhtml
	def new  
		@user_session = UserSession.new  
	end 

  def create
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save  
      flash[:notice] = "Successfully logged in."  
      redirect_to root_url  
    else  
    	note_failed_signin
      render :action => 'new'  
    end  
  end  

  def destroy  
    current_user_session.destroy 
    flash[:notice] = "Successfully logged out."  
    redirect_to root_url
  end  

	protected
		# Track failed login attempts
		def note_failed_signin
			flash[:error] = "Couldn't log you in as '#{params[:login]}'"
			logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
		end
		
end
