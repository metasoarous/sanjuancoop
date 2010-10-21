class MembersController < ApplicationController
	# Be sure to include AuthenticationSystem in Application Controller instead
	# include AuthenticatedSystem
	
	# Protect these actions behind an admin login
	# before_filter :admin_required, :only => [:index, :suspend, :unsuspend, :destroy, :purge]
	before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
	before_filter :admin_authorize, :only => [:index, :destroy, :suspend, :unsuspend, :purge]
	before_filter :only => [:show, :update] do |controller|
		controller.send(:owner_authorize, controller.params[:id]) or controller.send(:admin_authorize)
	end
	
	
	def index
		@users = Member.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @users }
		end
	end

	# GET /content_items/1
	# GET /content_items/1.xml
	def show
		@user = Member.find(params[:id])
		@topic_subscriptions = @user.forum_topic_subscriptions.paginate(:page => params[:page], :per_page => 20)

		respond_to do |format|
			format.html # show.html.erb
			format.xml	{ render :xml => @user }
		end
	end

	# render new.rhtml
	def new
		@user = Member.new
	end
 
	def create
		logout_keeping_session!
		@user = Member.new(params[:user])
		@user.register! if @user && @user.valid?
		success = @user && @user.valid?
		if success && @user.errors.empty?
			redirect_back_or_default('/')
			flash[:notice] = "Thanks for signing up!	We're sending you an email with your activation code. (The email should show up within a few minutes - if it doesn't, check your spam folder or email us at sanjuancoop@gmail.com)"
		else
			flash[:error]	= "We couldn't set up that account, sorry.	Please try again, or contact an admin (link is above)."
			render :action => 'new'
		end
	end

	def activate
		logout_keeping_session!
		user = Member.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
		case
		when (!params[:activation_code].blank?) && user && !user.active?
			user.activate!
			flash[:notice] = "Signup complete! Please sign in to continue."
			redirect_to '/login'
		when params[:activation_code].blank?
			flash[:error] = "The activation code was missing.	Please follow the URL from your email."
			redirect_back_or_default('/')
		else 
			flash[:error]	= "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
			redirect_back_or_default('/')
		end
	end
	
	def edit
		@user = Member.find(params[:id])
	end
	
	def update
		@user = Member.find(params[:id])
		respond_to do |format|
			if @user.update_attributes(params[:user])
				flash[:notice] = 'Member info was successfully updated.'
				format.html { redirect_to @user }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	def suspend
		@user.suspend! 
		redirect_to users_path
	end

	def unsuspend
		@user.unsuspend! 
		redirect_to users_path
	end

	def destroy
		@user.delete!
		redirect_to users_path
	end

	def purge
		@user.destroy
		redirect_to users_path
	end
	
	# There's no page here to update or destroy a user.	If you add those, be
	# smart -- make sure you check that the visitor is authorized to do so, that they
	# supply their old password along with a new one to update it, etc.
	
	# These following password reset etc methods were taken from railsonedge.blogspot.com 
	# post on Restful Authentication (part 3 of 3)
	def change_password
		return unless request.post?
		if Member.authenticate(current_user.login, params[:old_password])
			if ((params[:password] == params[:password_confirmation]) && 
														!params[:password_confirmation].blank?)
				current_user.password_confirmation = params[:password_confirmation]
				current_user.password = params[:password]

				if current_user.save
					flash[:notice] = "Password successfully updated" 
					redirect_to profile_url(current_user.login)
				else
					flash[:alert] = "Password not changed" 
				end

			else
				flash[:alert] = "New Password mismatch" 
				@old_password = params[:old_password]
			end
		else
			flash[:alert] = "Old password incorrect" 
		end
	end

	#gain email address
	def forgot_password
		return unless request.post?
		if @user = Member.find_by_email(params[:user][:email])
			@user.forgot_password
			@user.save
			redirect_back_or_default('/')
			flash[:notice] = "A password reset link has been sent to your email address" 
		else
			flash[:alert] = "Could not find a user with that email address" 
		end
	end

	#reset password
	def reset_password
		@user = Member.find_by_password_reset_code(params[:id])
		return if @user unless params[:user]

		if ((params[:user][:password] && params[:user][:password_confirmation]) && 
														!params[:user][:password_confirmation].blank?)
			self.current_user = @user #for the next two lines to work
			current_user.password_confirmation = params[:user][:password_confirmation]
			current_user.password = params[:user][:password]
			@user.reset_password
			flash[:notice] = current_user.save ? "Password reset success." : "Password reset failed." 
			redirect_back_or_default('/')
		else
			flash[:alert] = "Password mismatch" 
		end	
	end
	
	
protected
	def find_user
		@user = Member.find(params[:id])
	end
end
