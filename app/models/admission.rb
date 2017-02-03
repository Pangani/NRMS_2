class Admission < ActiveRecord::Base
	belongs_to :child
	before_validation :set_admission_date
	after_save :setID

#///////////////////////////////////////////////////////////////////
	scope :Is_muac, lambda{where(:admission_criteria => "muac")}
	scope :Is_z_score, lambda{where(:admission_criteria => "z_score")}
	scope :Is_oedema, lambda{where(:admission_criteria => "bilateral_oedema")}
	scope :Is_bmi, lambda{where(:admission_criteria => "bmi_for_age")}

#////////////////////////////////////////////////////////////////////
	#Validations
	as_enum :admission_type, [:new_admission, :relapse, :readmission], map: :string, source: :admission_type 
	as_enum :admission_criteria, [:muac, :z_score, :bilateral_oedema, :bmi_for_age, :other], map: :string, source: :admission_criteria

#////////////////////////////////////////////////////////////////////
	def set_admission_date
		self.date_of_admission = Time.now.to_date
	end

	def setID
		@child = Child.last
		@child.admission = Admission.find_by_id(@child.id)
	end

	
	#============================================
		#set admission_criteria based on age, height and presence of oedema
	def self.add_admission_criteria
		if @child.age_in_months < 60
			admission_criteria = 'muac' if @child.anthropometry.muac < 11.5 && @child.anthropometry.height > 65
					
		else
			if @child.anthropometry.oedema != 'no_oedema'
				admission_criteria = 'bilateral_oedema'
			else
				admission_criteria = 'z_score'
			end
		end
	end
end
