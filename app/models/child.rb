class Child < ActiveRecord::Base
	#Associations
	has_one :admission, :foreign_key => 'child_id', :dependent => :destroy
	has_one :discharge, :foreign_key => 'child_id', :dependent => :destroy
	has_many :tests, :foreign_key => 'child_id', :dependent => :destroy
	has_one :anthropometry, :foreign_key => 'child_id', :dependent => :destroy
	has_many :feed_plans, :foreign_key => 'child_id', :dependent => :destroy
	has_many :follow_ups, :foreign_key => 'child_id', :dependent => :destroy
	has_one :routine_treatment, :foreign_key => 'child_id', :dependent => :destroy
		
#/////////////////////////////////////////////////////////////////////
	#callbacks

#////////////////////////////////////////////////////////////////////
	#validations
	validates :reg_number, uniqueness: true, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :guardian_name, presence: true
	validates :village, presence: true
	validates :trad_authority, presence: true
	validates :district, presence: true
#////////////////////////////////////////////////////////////////////
	scope :is_twin, lambda{where(:twin_child => "Yes")}
	scope :is_male, lambda{where(:sex => 'Male')}
	scope :is_male, lambda{where(:sex => 'Female')}
	scope :on_art, lambda{where(:on_ART => "Yes")}
	scope :search, lambda { |query|
		where(["reg_number LIKE ?", "%#{query}%"])
		}

#/////////////////////////////////////////////////////////////////////
	#Variables with multiple options
	as_enum :maternal_HIV_serostatus, [:RR, :NR, :unknown], :map=> :string, source: :maternal_HIV_serostatus
	as_enum :twin_child, [:Yes, :no], map: :string, source: :twin_child
	as_enum :sex, [:Male, :Female], :map => :string, source: :sex
	as_enum :HIV_serostatus, [:RR, :NR, :unknown], :map => :string, source: :HIV_serostatus
	as_enum :on_ART, [:Yes, :No], map: :string, source: :on_ART
	
#/////////////////////////////////////////////////////////////////////

	def age(today = Date.today)
	    return nil if self.dob.nil?
	    # This code better accounts for leap years
	    child_age = (today.year - self.dob.year) + ((today.month - self.dob.month) + ((today.day - self.dob.day) < 0 ? -1 : 0) < 0 ? -1 : 0)
	end

	#changing age from years to months
	def age_in_months(today = Date.today)
	    years = (today.year - self.dob.year)
	    months = (today.month - self.dob.month)
	    (years * 12) + months
	end
	#===========================================	
	def full_name
		first_name + " "+ last_name
	end

	#===========================================
	#this is for a child aged 5 years and above
	# def check_for_bmi
	# end

	def done_assessment
		@child = Child.find_by_id(self.id)
		if !(@child.admission.nil? && @child.anthropometry.nil?)
			return true
		end
	end
#//////////////////////////////////////////////////////////////////////
	#methods for a multi-step form of registering a child
	def current_step
		@current_step || steps.first
	end

	#the array of form partials
	def steps
		%w[register anthropometry medic]
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


