class Routinetreatment < ActiveRecord::Base
	belongs_to :child
	before_validation :set_date

#///////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :vitamin_A, [:do_not_use, :half_capsule, :single_dose ], map: :string, source: :vitamin_A
	as_enum :folic_acid, [:single_dose], map: :string, source: :folic_acid
	as_enum :albendazole, [:do_not_use, :mg_200, :mg_400], map: :string, source: :albendazole
	as_enum :amoxicilic_antibiotic, [:do_not_use, :mg_125, :mg_250, :mg_500], map: :string, source: :amoxicilic_antibiotic
	
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

	def self.vit_dosage(age)
		if @age < 6.0
			return vitamin_A = "DO_NOT_USE"
		elsif @age > 5.9 && @age < 12.0 #only those aged above 6 months
			return vitamin_A = "Half_capsule"
		else
			return vitamin_A = "one_capsule"
		end
	end

	def self.amoxicilin_dosage(weight)
	# the method does not specify on whether dosage administered is syrup or tablet
	# It will be specified in views
		@weight = weight.to_f

		amoxicilin_antibiotic = nil

		if @weight > 2.0 #consideronly those over 2kg
			if @weight > 2.0 && @weight < 10.1
				return amoxicilin_antibiotic = "125mg"
			elsif @weight > 10.1 && @weight < 30.1
				return amoxicilin_antibiotic = "250mg"
			else
				return amoxicilin_antibiotic = "500mg"
			end

		else #EXCEPT under 2 KG
			return amoxicilin_antibiotic = "DO_NOT_USE"
		end

	end

	def self.folic_dosage
		return folic_acid = "single_dose"
	end

	def self.albendazole_dosage(age)
		if @age < 12.0
			return albendazole = "DO_NOT_USE"
		elsif @age > 11.9 && @age < 24 #Only given to those aged 1 year and above
			return albendazole = "200mg"
		else
			return albendazole = "400mg"			
		end
	end

	def self.fansidar_dosage(age, weight)
	#If in Malarial area..that to be included in Facility table
	#As a matter of fact, it is 25mg / kg
	# that is if weight=12 then dosage is 25*12=150mg
	# Most facilities use tablets/pills,  so we just use weight-range

		@weight = weight.to_f

		if age.to_f > 2.0 #Should be over 2 months
			if @weight > 4.0 && @weight < 5.1 #
				return fansidar = "quarter_tablet" #This contains 125mg

			elsif @weight > 5.1 && @weight < 10.1 
				return fansidar = "half_tablet" #This contains 250mg

			elsif @weight > 10.1 && @weight < 20.0
				return fansidar = "one_tablet" #this contains 500mg

			elsif @weight > 20.0 && @weight < 30.0
				return fansidar = "one_AND_half_tablet" #this contains 750mg

			elsif @weight > 30.0 && @weight < 45.1
				return fansidar = "two_tablets" #this contains 1000mg

			else
				return fansidar = "three_tablets" #this contains 1500mg
			end

		end
	end
end

#------------------------	END 	----------------------------------
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