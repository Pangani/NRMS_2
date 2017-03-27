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

	def vit_dosage(age, weight)
		@age = age.to_f #expect decimals

		@vitamin_A = nil
		if @age >= 6 #only those aged above 6 months
			if @age < 12
				return @vitamin_A = "half_capsule"
			else
			  	return @vitamin_A = "single_capsule"
			end

		else	#These are not expected to be in programme
			return @vitamin_A = "do_not_use"
		end
	end

	def amoxicilin_dosage(weight)
	# the method does not specify on whether dosage administered is syrup or tablet
	# It will be specified in views
		@weight = weight.to_f

		amoxicilin_antibiotic = nil

		if @weight < 2.0 #consideronly those over 2kg
			if @weight > 2.0 && @weight < 10.1
				return amoxicilin_antibiotic = "mg_125"
			elsif @weight = (10.1..30.0).to_a.join(', ')# @weight = 10.1 && @weight =< 30.0
				return amoxicilin_antibiotic = "mg_250"
			else
				return amoxicilin_antibiotic = "mg_500"
			end

		else #EXCEPT under KG
			return amoxicilin_antibiotic = "do_not_use"
		end

	end

	def folic_dosage
		@folic_acid = nil
		return @folic_acid = "single_dose"
	end

	def albendazole_dosage(age, weight)
		@age = age.to_f

		albendazole = nil

		if @age > 12.0 #Only given to those aged 1 year and above
			if @age < 24.0
				return albendazole = "mg_200"
			else
				return albendazole = "mg_400"
			end
		else
			albendazole = "do_not_use"
		end
	end

	def fansidar_dosage(age, weight)
	#If in Malarial area..that to be included in Facility table
	#As a matter of fact, it is 25mg / kg
	# that is if weight=12 then dosage is 25*12=150mg
	# Most facilities use tablets,  so we just use weight-range

		@weight = weight.to_f

		if age.to_f > 2.0 #Should be over 2 months
			if @weight = (4.1..5.0).to_a.join(', ') #@weight > 4.0 && @weight =< 5.0 #
				return fansidar = "quarter_tablet" #This contains 125mg

			elsif @weight = (5.1..10.0).to_a.join(', ')#@weight > 5.0 && @weight < 10.0 
				return fansidar = "half_tablet" #This contains 250mg

			elsif @weight = (10.1..20.0).to_a.join(', ')#@weight > 10.0 && @weight < 20.0
				return fansidar = "one_tablet" #this conatins 500mg

			elsif  @weight = (20.1..30.0).to_a.join(', ')# @weight > 20.0 && @weight =< 30.0
				return fansidar = "one_half_tablet" #this contains 750mg

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