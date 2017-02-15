class AssessmentController < ApplicationController
	#Call backs	
	before_action :find_child

#/////////////////////////////////////////////////////////////////////////////////
	def new
		@presenter = AssessmentPresenter.new
		@children = Child.all
	end

	def exception
    	RuntimeError.new("Here I am #{self}")
  	end

	def create		
		@presenter = AssessmentPresenter.new(params[:presenter])

		if @presenter.save
			
			flash[:notice] = "Assessment details have been recorded successfully"
			redirect_to(:controller => 'child',:action => 'index')
		else
			flash[:notice] = "Sorry failed to save...there must be an internal error!"
			render ('new')
		end
	end
	

	def show
	end

	def edit
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