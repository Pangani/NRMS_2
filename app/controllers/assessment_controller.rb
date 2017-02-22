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
		@presenter = AssessmentPresenter.new(params[:presenter])

		if @presenter.save
			#-----------------------------------------------------------------------------
		        # #CREATE A FEEDPLAN
		        # @ration = Foodration.amount_of_rutf(@child.anthropometry.weight)
		        # FeedPlan.create( 
			       #    :child_id => @child.id,
			       #    :admission_weight => @child.anthropometry.weight,
			       #    :today_weight => @child.anthropometry.weight,
			       #    :type_of_food => "RUTF",
			       #    :food_package => "sachet",
			       #    :amount_offered => @ration.sachets_per_week,
			       #    :amount_left => 0
		        #   )
			
			flash[:notice] = "Assessment details have been recorded successfully"
			redirect_to(:controller => 'child',:action => 'index')
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