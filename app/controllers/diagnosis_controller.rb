class DiagnosisController < ApplicationController
	before_action :find_child
	respond_to :js, only: :treatment

	def index
	end

	def new
		# @treatment = Routinetreatment.joins(:child).new(:child_id => @child.id)
	end

	def create
		# @treatment = Routinetreatment.new(treatment_params)

		# if @treatment.save && @feed.save

		# 	flash[:notice] = "Treatment plan for #{child.full_name} has been successfully created"
		# 	redirect_to(:action => 'treatment', :child_id => @child.id)
		# else
		# 	render('new')
		# end
	end

	def edit
		@treatment = Routinetreatment.joins(:child).find_by_id(params)
	end

private
	def treatment_params
		params.require(:treatment).permit(:child_id, :vitamin_A, :albendazole, :amoxicilin_antibiotic, :folic_acid)
	end

	def feed_params
		params.require(:feed).permit(:child_id, :date, :admission_weight, :today_weight, :type_of_food, :food_package, :amount_offered, :amount_left, :estimated_amount_vomited, :watery_diarrhoea)
	end

	def find_child
		if session[:child_id]
			@child = Child.find_by_id(session[:child_id])
		end
	end
end
