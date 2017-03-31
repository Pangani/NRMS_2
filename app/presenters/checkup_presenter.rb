class CheckupPresenter
	
	def initialize(params ={})
		params.each_pair do |attribute, value|
			self.send :"#{attribute}=", value
		end unless params.nil?	
	end

	def current_child(child)
		if child
			@current_child = Child.find_by_id(child.id)
		end
	end

	def followup
		@followup ||= Followup.new
	end

	def feedplan
		@feedplan ||= Feedplan.new
	end

	def test
		@test ||= Test.new
	end

	def save
		@followup.save

		@ration = Foodration.amount_of_rutf(@followup.weight) #returns number of sachets based on weight
		#======set some fields from other fields======
			#FOR REMAINING feedplan PARAMS
			#@feedplan.admission_weight = @current_child.anthropometry.weight
			@feedplan.today_weight = @followup.weight
			@feedplan.amount_offered = @ration.sachets_per_week.to_f if !@ration.blank?

			#FOR REMAINING test PARAMS
			@test.Appetite_test = @followup.appetite_test 

		#==============================================

		@current_child.feedplans << @feedplan
		@current_child.followups << @followup
		@current_child.tests << @test
		@followup.save && @feedplan.save && @test.save
	end

	# def edit
	# 	@followup = Followup.find_by_id(params[:id)
	# end

	def method_missing(model_attribute, *args)
		model, *method_name = model_attribute.to_s.split("_" )
		super unless self.respond_to? model.to_sym
		self.send(model.to_sym).send(method_name.join("_" ).to_sym, *args)

	end

end
