class NewslettersController < ApplicationController
	# GET /newsletters
	# GET /newsletters.xml
	
	before_filter :admin_authorize, :except => [:index, :show]
	
	def index
		@newsletters = Newsletter.all.sort {|letter1, letter2| letter2.created_at <=> letter1.created_at}
		@page_results = @newsletters.paginate(:page => params[:page], :per_page => 4)

		respond_to do |format|
			format.html # index.html.haml
			format.xml	{ render :xml => @newsletters }
		end
	end

	# GET /newsletters/1
	# GET /newsletters/1.xml
	def show
		@newsletter = Newsletter.find(params[:id])

		respond_to do |format|
			format.html # show.html.haml
			format.xml	{ render :xml => @newsletter }
		end
	end

	# GET /newsletters/new
	# GET /newsletters/new.xml
	def new
		@newsletter = Newsletter.new(:mail => true, :subject => "Weekly Newsletter!")

		respond_to do |format|
			format.html # new.html.haml
			format.xml	{ render :xml => @newsletter }
		end
	end

	# GET /newsletters/1/edit
	def edit
		@newsletter = Newsletter.find(params[:id])
	end

	# POST /newsletters
	# POST /newsletters.xml
	def create
		@newsletter = Newsletter.new(params[:newsletter])

		respond_to do |format|
			if @newsletter.save
				flash[:notice] = 'Newsletter was successfully created.'
				format.html { redirect_to(newsletters_path) }
				format.xml	{ render :xml => @newsletter, :status => :created, :location => @newsletter }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @newsletter.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /newsletters/1
	# PUT /newsletters/1.xml
	def update
		@newsletter = Newsletter.find(params[:id])

		respond_to do |format|
			if @newsletter.update_attributes(params[:newsletter])
				flash[:notice] = 'Newsletter was successfully updated.'
				format.html { redirect_to(newsletters_path) }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @newsletter.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /newsletters/1
	# DELETE /newsletters/1.xml
	def destroy
		@newsletter = Newsletter.find(params[:id])
		@newsletter.destroy

		respond_to do |format|
			format.html { redirect_to(newsletters_url) }
			format.xml	{ head :ok }
		end
	end
end
