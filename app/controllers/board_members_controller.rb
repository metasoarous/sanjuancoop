class BoardMembersController < ApplicationController
  # GET /board_members
  # GET /board_members.xml
  def index
    @board_members = BoardMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @board_members }
    end
  end

  # GET /board_members/1
  # GET /board_members/1.xml
  def show
    @board_member = BoardMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @board_member }
    end
  end

  # GET /board_members/new
  # GET /board_members/new.xml
  def new
    @board_member = BoardMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @board_member }
    end
  end

  # GET /board_members/1/edit
  def edit
    @board_member = BoardMember.find(params[:id])
  end

  # POST /board_members
  # POST /board_members.xml
  def create
    @board_member = BoardMember.new(params[:board_member])

    respond_to do |format|
      if @board_member.save
        flash[:notice] = 'BoardMember was successfully created.'
        format.html { redirect_to(@board_member) }
        format.xml  { render :xml => @board_member, :status => :created, :location => @board_member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @board_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /board_members/1
  # PUT /board_members/1.xml
  def update
    @board_member = BoardMember.find(params[:id])

    respond_to do |format|
      if @board_member.update_attributes(params[:board_member])
        flash[:notice] = 'BoardMember was successfully updated.'
        format.html { redirect_to(@board_member) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @board_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /board_members/1
  # DELETE /board_members/1.xml
  def destroy
    @board_member = BoardMember.find(params[:id])
    @board_member.destroy

    respond_to do |format|
      format.html { redirect_to(board_members_url) }
      format.xml  { head :ok }
    end
  end
end
