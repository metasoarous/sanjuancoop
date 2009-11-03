class ForumCategorySubscriptionsController < ApplicationController

  before_filter :find_forum_category_subscription

  FORUM_CATEGORY_SUBSCRIPTIONS_PER_PAGE = 20

  def create
    @forum_category_subscription = ForumCategorySubscription.new(params[:forum_category_subscription])
    respond_to do |format|
      if @forum_category_subscription.save
        flash[:notice] = 'ForumCategorySubscription was successfully created.'
        format.html { redirect_to @forum_category_subscription }
        format.xml  { render :xml => @forum_category_subscription, :status => :created, :location => @forum_category_subscription }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_category_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @forum_category_subscription.destroy
        flash[:notice] = 'ForumCategorySubscription was successfully destroyed.'        
        format.html { redirect_to forum_category_subscriptions_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'ForumCategorySubscription could not be destroyed.'
        format.html { redirect_to @forum_category_subscription }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @forum_category_subscriptions = ForumCategorySubscription.paginate(:page => params[:page], :per_page => FORUM_CATEGORY_SUBSCRIPTIONS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @forum_category_subscriptions }
    end
  end

  def edit
  end

  def new
    @forum_category_subscription = ForumCategorySubscription.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @forum_category_subscription }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @forum_category_subscription }
    end
  end

  def update
    respond_to do |format|
      if @forum_category_subscription.update_attributes(params[:forum_category_subscription])
        flash[:notice] = 'ForumCategorySubscription was successfully updated.'
        format.html { redirect_to @forum_category_subscription }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_category_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_forum_category_subscription
    @forum_category_subscription = ForumCategorySubscription.find(params[:id]) if params[:id]
  end

end