class MembershipsController < ApplicationController

  before_filter :find_membership

  MEMBERSHIPS_PER_PAGE = 20

  def create
    @membership = Membership.new(params[:membership])
    respond_to do |format|
      if @membership.save
        flash[:notice] = 'Membership was successfully created.'
        format.html { redirect_to @membership }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @membership.destroy
        flash[:notice] = 'Membership was successfully destroyed.'        
        format.html { redirect_to memberships_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Membership could not be destroyed.'
        format.html { redirect_to @membership }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @memberships = Membership.paginate(:page => params[:page], :per_page => MEMBERSHIPS_PER_PAGE, :order => "last_name")
    respond_to do |format|
      format.html
      format.xml  { render :xml => @memberships }
    end
  end

  def edit
  end

  def new
    @membership = Membership.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @membership }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @membership }
    end
  end

  def update
    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        flash[:notice] = 'Membership was successfully updated.'
        format.html { redirect_to @membership }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_membership
    @membership = Membership.find(params[:id]) if params[:id]
  end

end