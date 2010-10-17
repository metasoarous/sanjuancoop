class DistributorsController < ApplicationController
  # GET /distributors
  # GET /distributors.xml
  def index
    @distributors = Distributor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @distributors }
    end
  end

  # GET /distributors/1
  # GET /distributors/1.xml
  def show
    @distributor = Distributor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @distributor }
    end
  end

  # GET /distributors/new
  # GET /distributors/new.xml
  def new
    @distributor = Distributor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @distributor }
    end
  end

  # GET /distributors/1/edit
  def edit
    @distributor = Distributor.find(params[:id])
  end

  # POST /distributors
  # POST /distributors.xml
  def create
    @distributor = Distributor.new(params[:distributor])

    respond_to do |format|
      if @distributor.save
        flash[:notice] = 'Distributor was successfully created.'
        format.html { redirect_to(@distributor) }
        format.xml  { render :xml => @distributor, :status => :created, :location => @distributor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @distributor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /distributors/1
  # PUT /distributors/1.xml
  def update
    @distributor = Distributor.find(params[:id])

    respond_to do |format|
      if @distributor.update_attributes(params[:distributor])
        flash[:notice] = 'Distributor was successfully updated.'
        format.html { redirect_to(@distributor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @distributor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /distributors/1
  # DELETE /distributors/1.xml
  def destroy
    @distributor = Distributor.find(params[:id])
    @distributor.destroy

    respond_to do |format|
      format.html { redirect_to(distributors_url) }
      format.xml  { head :ok }
    end
  end
end
