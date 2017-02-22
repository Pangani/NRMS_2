class CheckUpController < ApplicationController
	#include check_up_helper
	before_action :find_child

#/////////////////////////////////////////////////////////////////////////
	def index
		@child_follows = Followup.where(:child_id => @child.id)
	end

#===============================check_up/summary=====================================
	def summary
		@follows = Followup.where(:child_id => @child.id).limit(2)
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
		@follow = Followup.new(follow_params)
		@child.follow_ups << @follow

		if @follow.save
			#----Update the feedplan table upon follow up--------

	        # @ration = Foodration.amount_of_rutf(@follow.weight)
	        # @feed = FeedPlan.create( 
					    #       :child_id => @child.id,
					    #       :admission_weight => @child.anthropometry.weight,
					    #       :today_weight => @follow.weight,
					    #       :type_of_food => "RUTF",
					    #       :food_package => "sachet",
					    #       :amount_offered => @ration.sachets_per_week,
					    #       :amount_left => 0
	        #  						 )
			#-----Update the tests table------------------------
			redirect_to(:action => 'show', :id => @follow.id )
		else
			render('new')
		end
	end

#==============================check_up/show==========================================
	def show
		@follow = Followup.find(params[:id])
	end

#=====================================================================================
	def display
	end

#===============================check_up/edit=========================================
	def edit
    	@follow =Followup.find(params[:id])
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
			@child = Child.find(session[:child_id])
		end
	end
end
