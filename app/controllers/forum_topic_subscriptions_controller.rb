class ForumTopicSubscriptionsController < ApplicationController

	before_filter :find_forum_topic_subscription
	
	before_filter :admin_authorize, :only => :index

	FORUM_TOPIC_SUBSCRIPTIONS_PER_PAGE = 20

	def create
		@forum_topic_subscription = ForumTopicSubscription.new(params[:forum_topic_subscription])
		respond_to do |format|
			if @forum_topic_subscription.save
				flash[:notice] = 'You are now subscribed to this Forum Discussion'
				format.html { redirect_to @forum_topic_subscription.forum_topic }
				format.xml	{ render :xml => @forum_topic_subscription.forum_topic, :status => :created, :location => @forum_topic_subscription }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @forum_topic_subscription.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		redirect = params[:redirect]
		respond_to do |format|
			if @forum_topic_subscription.destroy
				flash[:notice] = 'You have been successfully unsubscribed.'
				format.html { redirect_to redirect || current_user }
				format.xml	{ head :ok }
			else
				flash[:error] = 'ForumTopicSubscription could not be destroyed.'
				format.html { redirect_to @forum_topic_subscription }
				format.xml	{ head :unprocessable_entity }
			end
		end
	end

	def index
		@forum_topic_subscriptions = ForumTopicSubscription.paginate(:page => params[:page], :per_page => FORUM_TOPIC_SUBSCRIPTIONS_PER_PAGE)
		respond_to do |format|
			format.html
			format.xml	{ render :xml => @forum_topic_subscriptions }
		end
	end

	def edit
	end

	def new
		@forum_topic_subscription = ForumTopicSubscription.new
		respond_to do |format|
			format.html
			format.xml	{ render :xml => @forum_topic_subscription }
		end
	end

	def show
		respond_to do |format|
			format.html
			format.xml	{ render :xml => @forum_topic_subscription }
		end
	end

	def update
		respond_to do |format|
			if @forum_topic_subscription.update_attributes(params[:forum_topic_subscription])
				flash[:notice] = 'ForumTopicSubscription was successfully updated.'
				format.html { redirect_to @forum_topic_subscription.forum_topic }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @forum_topic_subscription.errors, :status => :unprocessable_entity }
			end
		end
	end

	private

	def find_forum_topic_subscription
		@forum_topic_subscription = ForumTopicSubscription.find(params[:id]) if params[:id]
	end

end
