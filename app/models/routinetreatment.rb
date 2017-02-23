class Routinetreatment < ActiveRecord::Base
	belongs_to :child
	before_validation :set_date

#///////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :vitamin_A, [:half_capsule, :single_dose ], map: :string, source: :vitamin_A
	as_enum :folic_acid, [:single_dose], map: :string, source: :folic_acid
	as_enum :albendazole, [:do_not_use, :mg_200, :mg_400], map: :string, source: :albendazole
	as_enum :amoxicilic_antibiotic, [:mg_125, :mg_250, :mg_500], map: :string, source: :amoxicilic_antibiotic
	
#///////////////////////////////////////////////////////////////////////////////////////////////

	#            ON ADMISSION? 		AGE 	PRESCRIPTION 	DOSE 						TREATMENT
	#Vitamin A 	    Yes		     	6m < 1yr	100,000		1 Dose(1/2 capsule) 		one day
	#---------  	--------		>= 1yr		200,000		1 Dose(1 capsule)
	#Folic Acid 	2nd visit 		all  		5mg			1 Dose  					2nd visit if direct
	#Amoxicilin 	YES(if >2kg)	all  		125, 250 	3 times/day  				7 days
	#albendazole 	2nd visit 		>1yr  		200, 400	1 Dose  					if direct

#===============================================================================================
	#System to set reminder on the visit for necessary medication based on weight
				# - On admission: Vitamin A, Amoxicilin
				# - On 2nd visit: Folic acid, albendazole
#===============================================================================================
	def set_date
		self.date = Time.now.to_date
	end

	def self.set_medication(age, weight)
		# if age < 12
		# 	self.vitamin_A = "half_capsule"
		# else
		# end
	end
end

#please do not un-comment the following code, it is for reference purposes only

#=======================================MIGRATIION FILE========================================
#//////////////////////////////////////////////////////////////////////////////////////////////

# class CreateRoutineTreatments < ActiveRecord::Migration
#   def change
#     create_table :routine_treatments do |t|
#     	t.references :child, null: false
#     	t.date "date", :null => false
#     	t.string "vitamin_A", :null => false
#     	t.string "folic_acid", :limit => 20
#     	t.string "amoxicilin_antibiotic", :limit => 20
#     	t.string "albendazole", :limit => 40
#       t.timestamps null: false
#     end
#     add_index("routine_treatments", "child_id")
#   end
# end