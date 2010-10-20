class VolunteerTasksController < ApplicationController
	# GET /volunteer_tasks
	# GET /volunteer_tasks.xml
	
	before_filter :admin_authorize, :except => [:index, :show]
	
	def index
		@volunteer_tasks = VolunteerTask.all.sort {|a,b| a.order <=> b.order}
		
		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @volunteer_tasks }
		end
	end

	# GET /volunteer_tasks/1
	# GET /volunteer_tasks/1.xml
	def show
		@volunteer_task = VolunteerTask.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml	{ render :xml => @volunteer_task }
		end
	end

	# GET /volunteer_tasks/new
	# GET /volunteer_tasks/new.xml
	def new
		@volunteer_task = VolunteerTask.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml	{ render :xml => @volunteer_task }
		end
	end

	# GET /volunteer_tasks/1/edit
	def edit
		@volunteer_task = VolunteerTask.find(params[:id])
	end

	# POST /volunteer_tasks
	# POST /volunteer_tasks.xml
	def create
		@volunteer_task = VolunteerTask.new(params[:volunteer_task])

		respond_to do |format|
			if @volunteer_task.save
				flash[:notice] = 'VolunteerTask was successfully created.'
				format.html { redirect_to(@volunteer_task) }
				format.xml	{ render :xml => @volunteer_task, :status => :created, :location => @volunteer_task }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @volunteer_task.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /volunteer_tasks/1
	# PUT /volunteer_tasks/1.xml
	def update
		@volunteer_task = VolunteerTask.find(params[:id])

		respond_to do |format|
			if @volunteer_task.update_attributes(params[:volunteer_task])
				flash[:notice] = 'VolunteerTask was successfully updated.'
				format.html { redirect_to(@volunteer_task) }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @volunteer_task.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /volunteer_tasks/1
	# DELETE /volunteer_tasks/1.xml
	def destroy
		@volunteer_task = VolunteerTask.find(params[:id])
		@volunteer_task.destroy

		respond_to do |format|
			format.html { redirect_to(volunteer_tasks_url) }
			format.xml	{ head :ok }
		end
	end
end
