class MemberProductRequestJoinsController < ApplicationController
  # GET /member_product_request_joins
  # GET /member_product_request_joins.xml
  def index
    @member_product_request_joins = MemberProductRequestJoin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_product_request_joins }
    end
  end

  # GET /member_product_request_joins/1
  # GET /member_product_request_joins/1.xml
  def show
    @member_product_request_join = MemberProductRequestJoin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member_product_request_join }
    end
  end

  # GET /member_product_request_joins/new
  # GET /member_product_request_joins/new.xml
  def new
    @member_product_request_join = MemberProductRequestJoin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_product_request_join }
    end
  end

  # GET /member_product_request_joins/1/edit
  def edit
    @member_product_request_join = MemberProductRequestJoin.find(params[:id])
  end

  # POST /member_product_request_joins
  # POST /member_product_request_joins.xml
  def create
    @member_product_request_join = MemberProductRequestJoin.new(params[:member_product_request_join])

    respond_to do |format|
      if @member_product_request_join.save
        flash[:notice] = 'MemberProductRequestJoin was successfully created.'
        format.html { redirect_to(@member_product_request_join) }
        format.xml  { render :xml => @member_product_request_join, :status => :created, :location => @member_product_request_join }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_product_request_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_product_request_joins/1
  # PUT /member_product_request_joins/1.xml
  def update
    @member_product_request_join = MemberProductRequestJoin.find(params[:id])

    respond_to do |format|
      if @member_product_request_join.update_attributes(params[:member_product_request_join])
        flash[:notice] = 'MemberProductRequestJoin was successfully updated.'
        format.html { redirect_to(@member_product_request_join) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_product_request_join.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_product_request_joins/1
  # DELETE /member_product_request_joins/1.xml
  def destroy
    @member_product_request_join = MemberProductRequestJoin.find(params[:id])
    @member_product_request_join.destroy

    respond_to do |format|
      format.html { redirect_to(member_product_request_joins_url) }
      format.xml  { head :ok }
    end
  end
end
