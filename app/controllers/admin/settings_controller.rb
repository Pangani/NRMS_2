class Admin::SettingsController < ApplicationController
	def index
	end

	def new
		@facility = Facility.new
	end

	def create
		@facility = Facility.new(facility_params)

		if @facility.save
			flash[:notice] = "Details of a facility has added successfully..."
			redirect_to(:controller => 'settings', :action => 'index')
		else
			render('new')
		end
	end

	def show
		@facility = Facility.find_by_id(params[:id])
	end

	def edit
		@facility = Facility.find_by_id(params[:id])
	end

	def update
		@facility = Facility.find_by_id(params[:id])

	    if @facility.update_attributes(facility_params)
	      	flash[:notice] = "Facility details updated successfully"

	        redirect_to(:action => 'show', :id => @facility.id)
	    else
	      render('edit')
	    end
	end

	private
	def facility_params
		params.require(:facility).permit(:name, :location, :district, :facility_code, :has_nru,:has_sfp)
	end

end
