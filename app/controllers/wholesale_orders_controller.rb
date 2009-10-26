class WholesaleOrdersController < ApplicationController
  # GET /wholesale_orders
  # GET /wholesale_orders.xml
  def index
    if admin?
      @wholesale_orders = WholesaleOrder.all
    elsif current_member
      @wholesale_orders = current_member.wholesale_orders
    else
      @wholesale_orders = []
    end
    
    @content = Hash.new
    [:wholesale_ordering_preamble, 
      :wholesale_ordering_unfi, 
      :wholesale_ordering_azures, 
      :wholesale_ordering_rest].each do |item|
        @content[item] = ContentItem.find_by_tag(item.to_s)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wholesale_orders }
    end
  end

  # GET /wholesale_orders/1
  # GET /wholesale_orders/1.xml
  def show
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wholesale_order }
    end
  end

  # GET /wholesale_orders/new
  # GET /wholesale_orders/new.xml
  def new
    @wholesale_order = WholesaleOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wholesale_order }
    end
  end

  # GET /wholesale_orders/1/edit
  def edit
    @wholesale_order = WholesaleOrder.find(params[:id])
  end

  # POST /wholesale_orders
  # POST /wholesale_orders.xml
  def create
    @wholesale_order = WholesaleOrder.new(params[:wholesale_order].merge({:member_id => current_member.id}))

    respond_to do |format|
      if @wholesale_order.save
        flash[:notice] = 'WholesaleOrder was successfully created.'
        format.html { redirect_to(@wholesale_order) }
        format.xml  { render :xml => @wholesale_order, :status => :created, :location => @wholesale_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wholesale_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wholesale_orders/1
  # PUT /wholesale_orders/1.xml
  def update
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      if @wholesale_order.update_attributes(params[:wholesale_order])
        flash[:notice] = 'WholesaleOrder was successfully updated.'
        format.html { redirect_to(@wholesale_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wholesale_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wholesale_orders/1
  # DELETE /wholesale_orders/1.xml
  def destroy
    @wholesale_order = WholesaleOrder.find(params[:id])
    @wholesale_order.destroy

    respond_to do |format|
      format.html { redirect_to(wholesale_orders_url) }
      format.xml  { head :ok }
    end
  end
end
