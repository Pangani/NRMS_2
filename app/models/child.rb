class Child < ActiveRecord::Base
	#Associations
	has_one :admission, :foreign_key => 'child_id', :dependent => :destroy
	has_one :discharge, :foreign_key => 'child_id', :dependent => :destroy
	has_many :tests, :foreign_key => 'child_id', :dependent => :destroy
	has_one :anthropometry, :foreign_key => 'child_id', :dependent => :destroy
	has_many :feedplans, :foreign_key => 'child_id', :dependent => :destroy
	has_many :followups, :foreign_key => 'child_id', :dependent => :destroy
	has_one :routinetreatment, :foreign_key => 'child_id', :dependent => :destroy
		
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
	scope :is_female, lambda{where(:sex => 'Female')}
	scope :on_art, lambda{where(:on_ART => "Yes")}

	scope :has_hiv, lambda{where(:HIV_serostatus => "RR")}
	scope :has_no_hiv, lambda{where(:HIV_serostatus => "NR")}
	scope :has_maternal_hiv, lambda{where(:maternal_HIV_serostatus => "RR")}
	scope :no_maternal_hiv, lambda{where(:maternal_HIV_serostatus => "NR")}

	#Categorize 2 by 2 
	scope :male_6_months_old, lambda{where(:dob=>179.days.ago..Time.now, :sex=> "Male")}
	scope :female_6_months_old, lambda{where(:dob=>179.days.ago..Time.now, :sex=> 'Female')}

	scope :male_59_months_old, lambda{where(:dob=>59.months.ago..6.months.ago, :sex=> 'Male')}
	scope :female_59_months_old, lambda{where(:dob=>59.months.ago..6.months.ago, :sex=> 'Female')}

	scope :male_12_years_old, lambda{where(:dob=>144.months.ago..60.months.ago, :sex=> 'Male')}
	scope :female_12_years_old, lambda{where(:dob=>144.months.ago..60.months.ago, :sex=> "Female")}

	scope :hiv_both, lambda{where("HIV_serostatus = 'RR' AND maternal_HIV_serostatus = 'RR'")}
	scope :is_exposed, lambda{where("HIV_serostatus = 'unknown' AND maternal_HIV_serostatus = 'RR'")}
	#scope :search, lambda { |query|
		#where(["reg_number LIKE ?", "%#{query}%"])
		#}
	#scope :child_assess, lambda { |query|
		#where(["id LIKE ?", "%#{query}%"])
	#}





def self.search(search)
  if search
    where('reg_number LIKE ?', "%#{search}%")
  else
    nil
  end
end


#/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	#Variables with multiple options
	as_enum :maternal_HIV_serostatus, [:RR, :NR, :unknown], :map=> :string, source: :maternal_HIV_serostatus
	as_enum :twin_child, [:Yes, :no], map: :string, source: :twin_child
	as_enum :sex, [:Male, :Female], :map => :string, source: :sex
	as_enum :HIV_serostatus, [:RR, :NR, :unknown], :map => :string, source: :HIV_serostatus
	as_enum :on_ART, [:Yes, :No], map: :string, source: :on_ART
	
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#--------------------------AGE FROM DATE OF BIRTH----------------------------------
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
#==================================================================================
#--------------------------------FULL NAME-----------------------------------------
	def full_name
		first_name + " "+ last_name
	end
	#Concatenates the first_name to last_name
	#returns the Full name
#==================================================================================
#-------------------------ADMISSION CRITERIA TO OTP-------------------------------- 
	def self.eligible_for_admission
		#add muac, oedema and z-score
		@elig = Child.includes(:tests).where(tests: {
														:appetite_test => true,
														:alert => true
													})
		return nil if @elig.blank?
		@elig
	end
	#A Child who has Muac < 11.5cm, age between 6months - 11yrs, oedema grade none;+;++
	#AND has appetite, alert and clinically-well

	#===========================================

		#this is for a child aged 5 years and above
		# def check_for_bmi
		# end

	#===========================================
		#HIV-POSITIVE (if serostatus)

		# Admission Criteria (6months - 11 years)
		# 	W/H < 80% or
		# 	bilateral Oedema + & ++ or
		# 	MUAC < 12cm
		# AND has appetite, alert, clinically well
	#Otherwise refer to NRU

	#============================================

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

#please do not un-comment the following code, it is for reference purposes only

#===================================CHILDREN MIGRATION FILE=======================================
#/////////////////////////////////////////////////////////////////////////////////////////////////

# class CreateChildren < ActiveRecord::Migration
#   def change
#     create_table :children do |t|
#     	t.string "reg_number", :null => false, :unique => true
# 		t.string "first_name", :limit => 25, :null => false
# 	    t.string "last_name", :limit => 25, :null => false
# 	    t.string "guardian_name", :limit => 60, :null => false
# 	    t.string "twin_child", :null => false, :default => "no"
# 	    t.date "dob", :null => false
# 	    t.string "sex", :null => false
# 	    t.string "district", :null => false
# 	    t.string "trad_authority", :null => false
# 	    t.string "village", :limit => 50, :null => false
# 	    t.string "HIV_serostatus", null: false, :default => false
# 	    t.string "maternal_HIV_serostatus", :null => false, :default => "NR"
# 	    t.boolean "on_ART", null: false, :default => false    	

#       t.timestamps null: false
#     end
#   end
# end



