class BarterBoardEntriesController < ApplicationController
  # GET /barter_board_entries
  # GET /barter_board_entries.xml
  def index
    @barter_board_entries = BarterBoardEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @barter_board_entries }
    end
  end

  # GET /barter_board_entries/1
  # GET /barter_board_entries/1.xml
  def show
    @barter_board_entry = BarterBoardEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @barter_board_entry }
    end
  end

  # GET /barter_board_entries/new
  # GET /barter_board_entries/new.xml
  def new
    @barter_board_entry = BarterBoardEntry.new
    @barter_board_categories = BarterBoardCategory.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @barter_board_entry }
    end
  end

  # GET /barter_board_entries/1/edit
  def edit
    @barter_board_entry = BarterBoardEntry.find(params[:id])
    @barter_board_categories = BarterBoardCategory.all
  end

  # POST /barter_board_entries
  # POST /barter_board_entries.xml
  def create
    @barter_board_entry = BarterBoardEntry.new(params[:barter_board_entry].merge({:member_id => current_member.id}))

    respond_to do |format|
      if @barter_board_entry.save
        flash[:notice] = 'BarterBoardEntry was successfully created.'
        format.html { redirect_to(@barter_board_entry) }
        format.xml  { render :xml => @barter_board_entry, :status => :created, :location => @barter_board_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @barter_board_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /barter_board_entries/1
  # PUT /barter_board_entries/1.xml
  def update
    @barter_board_entry = BarterBoardEntry.find(params[:id])

    respond_to do |format|
      if @barter_board_entry.update_attributes(params[:barter_board_entry])
        flash[:notice] = 'BarterBoardEntry was successfully updated.'
        format.html { redirect_to(@barter_board_entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @barter_board_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /barter_board_entries/1
  # DELETE /barter_board_entries/1.xml
  def destroy
    @barter_board_entry = BarterBoardEntry.find(params[:id])
    @barter_board_entry.destroy

    respond_to do |format|
      format.html { redirect_to(barter_board_entries_url) }
      format.xml  { head :ok }
    end
  end
end
