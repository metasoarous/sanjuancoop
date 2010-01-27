class MembersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:index, :suspend, :unsuspend, :destroy, :purge]
  before_filter :find_member, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :admin_authorize, :only => [:index, :destroy, :suspend, :unsuspend, :purge]
  before_filter :only => [:show, :update] do |controller|
    controller.owner_authorize(controller.params[:id]) or controller.admin_authorize
  end
  
  
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /content_items/1
  # GET /content_items/1.xml
  def show
    @member = Member.find(params[:id])
    @topic_subscriptions = @member.forum_topic_subscriptions.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # render new.rhtml
  def new
    @member = Member.new
  end
 
  def create
    logout_keeping_session!
    @member = Member.new(params[:member])
    @member.register! if @member && @member.valid?
    success = @member && @member.valid?
    if success && @member.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code. (The email should show up within a few minutes - if it doesn't, check your spam folder or email us at sanjuancoop@gmail.com)"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    member = Member.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && member && !member.active?
      member.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a member with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    respond_to do |format|
      if @member.update_attributes(params[:member])
        flash[:notice] = 'Member info was successfully updated.'
        format.html { redirect_to @member }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  def suspend
    @member.suspend! 
    redirect_to members_path
  end

  def unsuspend
    @member.unsuspend! 
    redirect_to members_path
  end

  def destroy
    @member.delete!
    redirect_to members_path
  end

  def purge
    @member.destroy
    redirect_to members_path
  end
  
  # There's no page here to update or destroy a member.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.
  
  # These following password reset etc methods were taken from railsonedge.blogspot.com 
  # post on Restful Authentication (part 3 of 3)
  def change_password
    return unless request.post?
    if Member.authenticate(current_member.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && 
                            !params[:password_confirmation].blank?)
        current_member.password_confirmation = params[:password_confirmation]
        current_member.password = params[:password]

        if current_member.save
          flash[:notice] = "Password successfully updated" 
          redirect_to profile_url(current_member.login)
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
    if @member = Member.find_by_email(params[:member][:email])
      @member.forgot_password
      @member.save
      redirect_back_or_default('/')
      flash[:notice] = "A password reset link has been sent to your email address" 
    else
      flash[:alert] = "Could not find a user with that email address" 
    end
  end

  #reset password
  def reset_password
    @member = Member.find_by_password_reset_code(params[:id])
    return if @member unless params[:member]

    if ((params[:member][:password] && params[:member][:password_confirmation]) && 
                            !params[:member][:password_confirmation].blank?)
      self.current_member = @member #for the next two lines to work
      current_member.password_confirmation = params[:member][:password_confirmation]
      current_member.password = params[:member][:password]
      @member.reset_password
      flash[:notice] = current_member.save ? "Password reset success." : "Password reset failed." 
      redirect_back_or_default('/')
    else
      flash[:alert] = "Password mismatch" 
    end  
  end
  
  
protected
  def find_member
    @member = Member.find(params[:id])
  end
end
