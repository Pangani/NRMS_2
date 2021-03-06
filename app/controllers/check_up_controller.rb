class CheckUpController < ApplicationController
	#include check_up_helper
	before_action :find_child

#////////////////////////////////////////////////////////////////////////////////////
	def index
		@child_follows = Followup.where(:child_id => @child.id)
	end

#===============================check_up/summary=====================================
	def summary
		@follows = Followup.where(:child_id => @child.id).limit(2)
		@child_follows = Followup.where(:child_id => @child.id)
		# FollowUp.left_outer_joins(:feed_plans).where(:)
	end

#==============================check_up/new==========================================
	def new
		@follow = Followup.new(:child_id => @child.id)
		@children = Child.all
		#This works but it is not a good idea..should be improved with presenters/helpers
	end

#------------------------------------------------------------------------------------
	def create	
		@presenter = CheckupPresenter.new(params[:presenter])
		@presenter.current_child(@child)

		if @presenter.save
			flash[:notice] = "successfully updated the assessment details for #{@child.full_name}"
			redirect_to(:action => 'index', :child_id => @child.id )
		else
			flash[:notice] = "This is annoying!!! Whats wrong now?"
			render('new')
		end
	end

#==============================check_up/show==========================================
	def show
		@followup = Followup.find_by_child_id(params[:child_id])
		@test = Test.find_by_child_id(params[:child_id])
		@feedplan = Feedplan.find_by_child_id(params[:child_id])
	end

#=====================================================================================
	def display
		@follow = Followup.where(params[:child_id])
		
		@followup = Followup.find_by_child_id(params[:child_id])
		@test = Test.find_by_child_id(params[:child_id])
		@feedplan = Feedplan.find_by_child_id(params[:child_id])
	end

#===============================check_up/edit=========================================
	def edit
		@presenter = CheckupPresenter.edit
  	end

#-------------------------------------------------------------------------------------
	def update
	    @follow = Followup.find(params[:id])

	    if @follow.update_attributes(follow_params)
	      	flash[:notice] = "session card entries updated successfully"
	      	
	      	redirect_to(:action => 'show', :id => @follow.id)
	    else
	      render('edit')
	    end
	end	

private
	def follow_params
		params.require(:follow_up).permit(:weight, :MUAC, :z_score, :BMI, :height, :oedema, :clinician, :remark, :appetite_test, :clinical_status)
	end

	def find_child
		if session[:child_id]
			@child = Child.find_by_id(session[:child_id])
		end
	end
end
