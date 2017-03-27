class Admission < ActiveRecord::Base
	belongs_to :child
	before_validation :set_admission_date
	#after_save :setID
#///////////////////////////////////////////////////////////////////////////////////////////////////////////
	scope :Is_muac, lambda{where(:admission_criteria => "muac")}
	scope :Is_z_score, lambda{where(:admission_criteria => "z_score")}
	scope :Is_oedema, lambda{where(:admission_criteria => "bilateral_oedema")}
	scope :Is_bmi, lambda{where(:admission_criteria => "bmi_for_age")}

#///////////////////////////////////////////////////////////////////////////////////////////////////////////
	validates :admission_type, :referred_by, :admission_criteria, :presence => true
	#Validations
	as_enum :admission_type, [:new_admission, :relapse, :readmission], map: :string, source: :admission_type 
	as_enum :referred_by, [:Own, :NRU, :otherOTP], :map => :string, source: :referred_by
	as_enum :admission_criteria, [:muac, :z_score, :bilateral_oedema, :bmi_for_age, :other], map: :string, source: :admission_criteria

#///////////////////////////////////////////////////////////////////////////////////////////////////////////
	def set_admission_date
		self.date_of_admission = Time.now.to_date
	end
#=========================================================================================================
#--------------------------------------DEFINE ADMISSION CRITERIA--------------------------------------

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

#please do not un-comment the following code, it is for reference purposes only

#==================================ADMISSION MIGRATION FILE===========================================
#/////////////////////////////////////////////////////////////////////////////////////////////////////

# class CreateAdmissions < ActiveRecord::Migration
#   def change
#     create_table :admissions do |t|
# 	   	t.references :child, :null => false
# 	   	t.string "admission_type", :null => false, :default => "new_admission"
# 	    t.datetime "date_of_admission", null: false 
# 	    t.string "admission_criteria", null: false
#       t.timestamps null: false
#     end
#       add_index("admissions", "child_id")
#   end
# end

