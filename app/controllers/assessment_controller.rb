class AssessmentController < ApplicationController
	#Call backs	
	before_action :find_child

#/////////////////////////////////////////////////////////////////////////////////
	def new
		@presenter = AssessmentPresenter.new
		@children = Child.all
	end

	def exception
    	RuntimeError.new("Here I am #{self}") #to catch errors
  	end

#-----------------------------------------------------------------------------------------
	# AssessmentPresenter is a ruby class(presenter) that combines 3 models
	# namely admission, anthropometry and test
	def create
		session[:child_id] = @child.id		
		@presenter = AssessmentPresenter.new(params[:presenter])

		@presenter.current_child(@child)
		if @presenter.save
			#-----------------------------------------------------------------------------
		        #CREATE A FEEDPLAN
		        @ration = Foodration.amount_of_rutf(@child.anthropometry.weight)
		        @feed = Feedplan.new( 
			          :child_id => @child.id,
			          :admission_weight => @child.anthropometry.weight,
			          :today_weight => @child.anthropometry.weight,
			          :type_of_food => "RUTF",
			          :food_package => "sachet",
			          :amount_offered => @ration.sachets_per_week,
		          )
		        
		        #Create a tuple in RoutineTreatment..see model
		        @treatment = Routinetreatment.create(
		        		:child_id => @child.id,
		        		:vitamin_A => Routinetreatment.vit_dosage(@child.age_in_months),
		        		:folic_acid => Routinetreatment.folic_dosage,
		        		:fansidar => Routinetreatment.fansidar_dosage(@child.age_in_months, @child.anthropometry.weight),
		        		:amoxicilin_antibiotic => Routinetreatment.amoxicilin_dosage(@child.anthropometry.weight),
		        		:albendazole => Routinetreatment.albendazole_dosage(@child.age_in_months)
		        	)

		    # Make sure the feedplan and routinetreatment plan was created
		    # Notify if one fails
			if @treatment.save && @feed.save #Both saved
				flash[:notice] = "Assessment details have been recorded successfully"
				redirect_to(:controller => 'child',:action => 'index')

			elsif @treatment.save && !@feed.save # Feed failed
				flash[:notice] = "Nutritional treatment plan failed to be created..."
				redirect_to(:controller => 'child',:action => 'index')

			elsif !@treatment.save && @feed.save # Treatment failed..
				flash[:notice] = "Medical treatment plan failed to be created..."
				redirect_to(:controller => 'child',:action => 'index')

			else #Both failed...
				flash[:notice] = "Both treatments have been failed miserably..."
				redirect_to(:controller => 'child',:action => 'index')	
			end
			
		else
			flash[:notice] = "Sorry failed to save...there must be an internal error!"
			render ('new')
		end
	end
	
#/////////////////////////////////////////////////////////////////////////////////
private
	#----------------------------------------------------------------------------
	#To marry everything to a specific child
	def find_child
		if session[:child_id]
			@child = Child.find_by_id(session[:child_id])
		end
	end
end