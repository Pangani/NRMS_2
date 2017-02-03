class FeedplanController < ApplicationController
	before_action :find_child

 	def index
  		@feed = FeedPlan.where(:child_id => @child.id)
 	end

  	def new
  		@feed = FeedPlan.new(:child_id => @child.id)
  	end

  	def create
		@feed = FeedPlan.new(feed_params)

		#======================
		#filling in admission and current weight columns from Admission and FollowUp tables respectively 
		@feed.today_weight = @child.follow_ups.last.weight
		@feed.admission_weight = @child.admission.weight

		#======================

		if @feed.save
			flash[:notice] = "'#{@child.full_name}'s session updated successfully "
			redirect_to(:action => 'index', :child_id => @child.id)
		else
			render('new')
		end
	end

private
	def find_child
		if session[:child_id]
			@child = Child.find_by_id(session[:child_id])
		end
	end
end
