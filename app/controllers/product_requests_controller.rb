class ProductRequestsController < ApplicationController
  # GET /product_requests
  # GET /product_requests.xml
  def index
    @product_requests = ProductRequest.all
    @product_request_statuses = ProductRequestStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_requests }
    end
  end

  # GET /product_requests/1
  # GET /product_requests/1.xml
  def show
    @product_request = ProductRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_request }
    end
  end

  # GET /product_requests/new
  # GET /product_requests/new.xml
  def new
    #Don't know of a cleaner way to do this, but need to make sure that the default status is set to unorderd
    status_id = ProductRequestStatus.find_by_name("Unordered" || 1).id
    @product_request = ProductRequest.new(:product_request_status_id => status_id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_request }
    end
  end

  # GET /product_requests/1/edit
  def edit
    @product_request = ProductRequest.find(params[:id])
  end

  # POST /product_requests
  # POST /product_requests.xml
  def create
    @product_request = ProductRequest.new(params[:product_request])

    respond_to do |format|
      if @product_request.save
        flash[:notice] = 'ProductRequest was successfully created.'
        format.html { redirect_to(product_requests_url) }
        format.xml  { render :xml => @product_request, :status => :created, :location => @product_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_requests/1
  # PUT /product_requests/1.xml
  def update
    @product_request = ProductRequest.find(params[:id])

    respond_to do |format|
      if @product_request.update_attributes(params[:product_request])
        flash[:notice] = 'ProductRequest was successfully updated.'
        format.html { redirect_to(@product_request) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_requests/1
  # DELETE /product_requests/1.xml
  def destroy
    @product_request = ProductRequest.find(params[:id])
    @product_request.destroy

    respond_to do |format|
      format.html { redirect_to(product_requests_url) }
      format.xml  { head :ok }
    end
  end
end
