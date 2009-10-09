class BarterBoardCategoriesController < ApplicationController
  # GET /barter_board_categories
  # GET /barter_board_categories.xml
  def index
    @barter_board_categories = BarterBoardCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @barter_board_categories }
    end
  end

  # GET /barter_board_categories/1
  # GET /barter_board_categories/1.xml
  def show
    @barter_board_category = BarterBoardCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @barter_board_category }
    end
  end

  # GET /barter_board_categories/new
  # GET /barter_board_categories/new.xml
  def new
    @barter_board_category = BarterBoardCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @barter_board_category }
    end
  end

  # GET /barter_board_categories/1/edit
  def edit
    @barter_board_category = BarterBoardCategory.find(params[:id])
  end

  # POST /barter_board_categories
  # POST /barter_board_categories.xml
  def create
    @barter_board_category = BarterBoardCategory.new(params[:barter_board_category])

    respond_to do |format|
      if @barter_board_category.save
        flash[:notice] = 'BarterBoardCategory was successfully created.'
        format.html { redirect_to(@barter_board_category) }
        format.xml  { render :xml => @barter_board_category, :status => :created, :location => @barter_board_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @barter_board_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /barter_board_categories/1
  # PUT /barter_board_categories/1.xml
  def update
    @barter_board_category = BarterBoardCategory.find(params[:id])

    respond_to do |format|
      if @barter_board_category.update_attributes(params[:barter_board_category])
        flash[:notice] = 'BarterBoardCategory was successfully updated.'
        format.html { redirect_to(@barter_board_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @barter_board_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /barter_board_categories/1
  # DELETE /barter_board_categories/1.xml
  def destroy
    @barter_board_category = BarterBoardCategory.find(params[:id])
    @barter_board_category.destroy

    respond_to do |format|
      format.html { redirect_to(barter_board_categories_url) }
      format.xml  { head :ok }
    end
  end
end
