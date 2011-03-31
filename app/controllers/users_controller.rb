class UsersController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "New user successfully created."
      redirect_to root_url
    else
      flash[:error] = "There were errors with this form"
      render :action => 'new'
    end
  end
  
  def index
    @users = User.all_by_last.paginate :page => params[:page], :per_page => 25
  end
  
  def show
  end
  
  def edit
    #create_blank_subscriptions(@user)
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User data successfully updated.'
        format.html { redirect_to(can?(:read, User) ? users_path : root_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @user.destroy
        flash[:notice] = 'User was successfully destroyed.'        
        format.html { redirect_to users_path }
      else
        flash[:error] = 'User could not be destroyed.'
        format.html { redirect_to @user }
      end
    end
  end
	
	
protected
	def find_user
		@user = User.find(params[:id])
	end
end
