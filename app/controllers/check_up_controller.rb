class CheckUpController < ApplicationController
	#include check_up_helper

	before_action :find_child

#/////////////////////////////////////////////////////////////////////////
	def index
		@child_follows = FollowUp.where(:child_id => @child.id)
	end

	def new
		@follow = FollowUp.new(:child_id => @child.id)
		@children = Child.all
	end

	def create
		@follow = FollowUp.new(follow_params)

		if @follow.save
			redirect_to(:action => 'show', :id => @follow.id )
		else
			render('new')
		end
	end

	def show
		@follow = FollowUp.find(params[:id])
	end

	def edit
    	@follow =FollowUp.find(params[:id])
  	end

	def update
	    @follow = FollowUp.find(params[:id])

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
