class ForumTopicsController < ApplicationController
  # GET /forum_topics
  # GET /forum_topics.xml
  def index
    @forum_topics = ForumTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_topics }
    end
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.xml
  def show
    @forum_topic = ForumTopic.find(params[:id])
    @forum_posts = @forum_topic.forum_posts.paginate(:page => params[:page], :per_page => 20)
    @forum_topic_subscription = ForumTopicSubscription.new
    if current_member
      @forum_topic_subscription.member_id = current_member.id
      @forum_topic_subscription.forum_topic_id = @forum_topic.id
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_topic }
    end
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.xml
  def new
    @forum_topic = ForumTopic.new
    @forum_topic.forum_posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_topic }
    end
  end

  # GET /forum_topics/1/edit
  def edit
    @forum_topic = ForumTopic.find(params[:id])
  end

  # POST /forum_topics
  # POST /forum_topics.xml
  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])

    respond_to do |format|
      if @forum_topic.save
        flash[:notice] = 'ForumTopic was successfully created.'
        format.html { redirect_to(@forum_topic) }
        format.xml  { render :xml => @forum_topic, :status => :created, :location => @forum_topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.xml
  def update
    @forum_topic = ForumTopic.find(params[:id])

    respond_to do |format|
      if @forum_topic.update_attributes(params[:forum_topic])
        flash[:notice] = 'ForumTopic was successfully updated.'
        format.html { redirect_to(@forum_topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.xml
  def destroy
    @forum_topic = ForumTopic.find(params[:id])
    @forum_topic.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topics_url) }
      format.xml  { head :ok }
    end
  end
end
