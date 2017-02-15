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
#----------------------DISCHARGE CRITERIA FOR HIV+ CHILDREN------------------------------------
	# To be kept for a minimum of 1 month
	# discharged as cured after achieving a W/H >85% on 2 consecutive visits
	# referral to HTC if after 5 weeks in prog with no weight gain, no cure after 3months
	# if no target weight is reached after 4months
	# 	#discharge as non-responding case
	# 	non-responding may be provided with RUTF within the ARV service

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

