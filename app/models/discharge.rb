class Discharge < ActiveRecord::Base
	belongs_to :child
	#around_save :set_child_id
	#Associations
#////////////////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :outcome, [:cured, :died, :defaulted, :nonresponse, :transferred], map: :string, source: :outcome

#////////////////////////////////////////////////////////////////////////////////////////////////////////
	#to separate children by their outcome during discharge
	scope :while_cured, lambda {where(:outcome => "cured")}
	scope :while_dead, lambda {where(:outcome => "died")}
	scope :while_defaulted, lambda {where(:outcome => "defaulted")}
	scope :while_nonresponse, lambda {where(:outcome => "nonresponse")}
	scope :while_transferred, lambda {where(:outcome => "transferred")}

#////////////////////////////////////////////////////////////////////////////////////////////////////////

#----------------------DISCHARGE CRITERIA IN OTP---------------------------------------------------------
	#Suggest discharge if
		# Cured -> W/H >= 80%(where there is SFP) or W/H >= 85% (in the absence of SFP) for 
		# 		two consecutive visits AND 
		# 		MUAC >= 11.0 cm (Not independent)AND
		# 		No oedema for 2 consecutive visits
		# 		(minimum stay of 1 month for MUAC or W/H admissions or after NRU)

		# Defaulted -> Absent for 2 consecutive visits

		# Died -> died during time registered in OTP

		# Non-response -> Has not reached discharge criteria within 4 months...
		# 				Link the child to other programmes e.g IMCI, OVC, HTC, HBC ART clinics, 
		# 				target food distributions

		# Transferred to NRU -> Condition has been deteriorated and requires inpatient care

#----------------------DISCHARGE CRITERIA FOR HIV+ CHILDREN----------------------------------------------
	# To be kept for a minimum of 1 month
	# discharged as cured after achieving a W/H >85% on 2 consecutive visits
	# referral to HTC if after 5 weeks in prog with no weight gain, no cure after 3months
	# if no target weight is reached after 4months
	# 	#discharge as non-responding case
	# 	non-responding may be provided with RUTF within the ARV service

#-------------------------------------------------------------------------------------------------------
#======DISCHARGE PROCEDURES
	# Give feedback to the caregiver on the final outcome
		# Ø Ensure caregiver understands how to use any continuing medications
		# Ø Ensure caregiver understands importance of follow-up care (SFP or other programme)
		# Ø Give a final ration (1 week supply)
		# Ø Note discharge outcome in register and on monitoring and ration cards
		# Ø Counsel caregiver on good nutrition and cooking practices
		# Ø Advise the caregivers to immediately go to the nearest health facility if child refuses to
		# eat or has any of the following signs:
				# - high fever,
				# - frequent watery stools or stools with blood, diarrhea lasting more than 4 days
				# - difficult or fast breathing
				# - vomiting,
				# - not alert, very weak, unconscious, convulsions
				# - increase in oedema.
		# Ø If a child must be transferred to the NRU due to deterioration in condition, the
		# treatment and medications given must be noted in the child's health passport, along
		# with a referral for NRU treatment.
	# All OTP discharges should be sent to the SFP, where available, to stay for a minimum
	# of 4 months.
	
end

#please do not un-comment the following code, it is for reference purposes only

#==================================MIGRATION FILE==================================================
# /////////////////////////////////////////////////////////////////////////////////////////////////

	# class CreateDischarges < ActiveRecord::Migration
	#   def change
	#     create_table :discharges do |t|
	#     	t.references :child, :null => false
	#     	t.datetime "date_of_discharge", null: false
	#     	t.string "programme", :limit => 25, :null => false
	#     	t.text "proposed_treatment"
	#     	t.text "proposed_diet"
	#     	t.string "outcome", :limit => 60, :null => false, :default => "cured"
	#     	t.integer "length_of_stay", null: false 

	#       #t.timestamps null: false
	#     end
	# 	    add_index("discharges", "child_id")

	#   end
	# end

