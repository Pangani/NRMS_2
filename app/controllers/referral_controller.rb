class ReferralController < ApplicationController
	before_action :find_child

	def index
		if @child.referrals
	  		@c_referral = Child.joins(:referrals).all
	  	else
	  		render 'new'
	  	end
	end

	def new
		@referral = Referral.new
	end

	def create
		@referral = Referral.new

		@child.referrals << @referral
		if @referral.save
			redirect_to(:action => 'show', :id => @referral.id)
		else
			render('new')
			flash[:notice] = "Please check in all fields that are filled with appropiate details..."
		end
	end

	def show
		@referral = Child.join(:referrals).where(:child_id => @child.id)
	end

	def edit
		@referral = Referral.find_by_id(params[:id])
	end

	def update
		@referral = Referral.find_by_id(params[:id])

	    if @referral.update_attributes(follow_params)
	      	flash[:notice] = "sreferral details updated successfully"
	      	
	      	redirect_to(:action => 'show', :id => @referral.id)
	    else
	      render('edit')
	    end
	end

	def confirm
		@referral = Referral.find_by_id(params[:id])
	end


	private
	def find_child
	  	if session[:child_id]
			@child = Child.find_by_id(session[:child_id])
		end
	end
end
