class AssessmentPresenter
	attr_writer :current_step
    
	def initialize(params ={})
		params.each_pair do |attribute, value|
			self.send :"#{attribute}=", value
		end unless params.nil?	
	end

	def anthropometry
		@anthropometry ||= Anthropometry.new
	end

	def admission
		@admission ||= Admission.new
	end

	def current_child(child)
		if child
			@current_child = Child.find_by_id(child.id)
		end
	end

	def test
		@test ||= Test.new
	end

	def save
		@current_child.admission = @admission
		@current_child.anthropometry = @anthropometry
		@current_child.tests << @test
		@admission.save && @anthropometry.save && @test.save
	end

	def method_missing(model_attribute, *args)
		model, *method_name = model_attribute.to_s.split("_" )
		super unless self.respond_to? model.to_sym
		self.send(model.to_sym).send(method_name.join("_" ).to_sym, *args)

	end

	#///////////////////////////////////////////////////////////////////////
	# This part is for the multiple form-step

	#the array of form partials
	def steps
		%w[register anthropometry medic]
	end
	
	def current_step
		@current_step || steps.first
	end

	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
		current_step == steps.first
	end

	def last_step?
		current_step == steps.last
	end

	def all_valid?
		steps.all? do |step|
			self.current_step = step
			valid?
		end
	end

end