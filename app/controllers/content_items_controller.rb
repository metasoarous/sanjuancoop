class ContentItemsController < ApplicationController
  # GET /content_items
  # GET /content_items.xml
  before_filter :logged_in_authorize, :only => :index
  before_filter :admin_authorize, :except => [:index, :show]
  
  def index
    @content_items = ContentItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @content_items }
    end
  end

  # GET /content_items/1
  # GET /content_items/1.xml
  def show
    if params[:id]
      @content_item = ContentItem.find(params[:id])
    elsif params[:tag]
      @content_item = ContentItem.find_or_create_by_tag(params[:tag])
    else
      HoptoadNotifier.notify(
        :error_class => "Content Item Error",
        :error_message => "Neither a tag nor an id were passed into the params hash",
        :request => {:params => params}
      )
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content_item }
    end
  end

  # GET /content_items/new
  # GET /content_items/new.xml
  def new
    @content_item = ContentItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content_item }
    end
  end

  # GET /content_items/1/edit
  def edit
    @content_item = ContentItem.find(params[:id])
  end

  # POST /content_items
  # POST /content_items.xml
  def create
    @content_item = ContentItem.new(params[:content_item])

    respond_to do |format|
      if @content_item.save
        flash[:notice] = 'ContentItem was successfully created.'
        format.html { redirect_to(@content_item) }
        format.xml  { render :xml => @content_item, :status => :created, :location => @content_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /content_items/1
  # PUT /content_items/1.xml
  def update
    @content_item = ContentItem.find(params[:id])

    respond_to do |format|
      if @content_item.update_attributes(params[:content_item])
        flash[:notice] = 'ContentItem was successfully updated.'
        format.html { redirect_to(@content_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /content_items/1
  # DELETE /content_items/1.xml
  def destroy
    @content_item = ContentItem.find(params[:id])
    @content_item.destroy

    respond_to do |format|
      format.html { redirect_to(content_items_url) }
      format.xml  { head :ok }
    end
  end
end
