class VolunteerOfferingsController < ApplicationController
  # GET /volunteer_offerings
  # GET /volunteer_offerings.xml
  def index
    @volunteer_offerings = VolunteerOffering.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteer_offerings }
    end
  end

  # GET /volunteer_offerings/1
  # GET /volunteer_offerings/1.xml
  def show
    @volunteer_offering = VolunteerOffering.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @volunteer_offering }
    end
  end

  # GET /volunteer_offerings/new
  # GET /volunteer_offerings/new.xml
  def new
    @volunteer_offering = VolunteerOffering.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @volunteer_offering }
    end
  end

  # GET /volunteer_offerings/1/edit
  def edit
    @volunteer_offering = VolunteerOffering.find(params[:id])
  end

  # POST /volunteer_offerings
  # POST /volunteer_offerings.xml
  def create
    @volunteer_offering = VolunteerOffering.new(params[:volunteer_offering])

    respond_to do |format|
      if @volunteer_offering.save
        flash[:notice] = 'VolunteerOffering was successfully created.'
        format.html { redirect_to(volunteer_tasks_path) }
        format.xml  { render :xml => @volunteer_offering, :status => :created, :location => @volunteer_offering }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @volunteer_offering.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /volunteer_offerings/1
  # PUT /volunteer_offerings/1.xml
  def update
    @volunteer_offering = VolunteerOffering.find(params[:id])

    respond_to do |format|
      if @volunteer_offering.update_attributes(params[:volunteer_offering])
        flash[:notice] = 'VolunteerOffering was successfully updated.'
        format.html { redirect_to(@volunteer_offering) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @volunteer_offering.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteer_offerings/1
  # DELETE /volunteer_offerings/1.xml
  def destroy
    @volunteer_offering = VolunteerOffering.find(params[:id])
    @volunteer_offering.destroy

    respond_to do |format|
      format.html { redirect_to(volunteer_tasks_path) }
      format.xml  { head :ok }
    end
  end
end
