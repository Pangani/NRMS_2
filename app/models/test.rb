class Test < ActiveRecord::Base
	belongs_to :child
	#before_validation :set_bfeeding

#////////////////////////////////////////////////////////////////////////////////////////////
validates :vomiting, :alert, :stools, :presence => true

#////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :Appetite_test, [:Yes, :No], map: :string, source: :Appetite_test 
	as_enum :stools, [:three, :four, :five], map: :string, source: :stools
	as_enum :yes_appetite, [:very_good, :good, :poor, :very_poor], map: :string, source: :yes_appetite
	as_enum :complementery_food, [:Yes, :None], :map => :string, source: :complementery_food
	as_enum :breastfeeding, [:Yes, :No], :map => :string, source: :breastfeeding

#///////////////////////////////////////////////////////////////////////////////////////////
	scope :appetite_pass, lambda {where(:Appetite_test => true)}
	scope :appetite_fail, lambda {where(:Appetite_test => false)}

#//////////////////////////////////////////////////////////////////////////////////////////
	def set_breastfeeding(child)
		if child
			@age = child.age_in_months

			if @age.to_f > 24
				return self.breastfeeding = "Yes"
			else
				return self.breastfeeding = "No"
			end
		end
	end
# -----------------------------------------------------------------------------------------
	# ALARM TRIGGER 
	# if medical condition deteriorates
	# 	- vomiting is always there
	# 	- stools are three or more times for 2 weeks now

#------------------------------------------------------------------------------------------
end

#please do not un-comment the following code, it is for reference only

#====================================TEST MIGRATION FILE======================================
#/////////////////////////////////////////////////////////////////////////////////////////////

# class CreateTests < ActiveRecord::Migration
#   def change
#     create_table :tests do |t|
#     	t.references :child, :null => false
#     	t.string "Appetite_test", :null => false
#     	t.string "breastfeeding", :limit => 5, null: false
#     	t.string "complementery_food", :limit => 5, :null => false
#     	t.boolean "vomiting", :limit => 10, :null => false
# 	    t.boolean "alert", null: false
# 	    t.string "stools", :limit => 10, :null => false
# 	    t.string "yes_appetite", :null => 20, :default => "good"
# 	    t.text "prev_medical_history", :limit => 60
# 	    t.string "clinician_name", :limit => 30, :null => false

#       #t.timestamps null: false
#     end
# 	   add_index("tests", "child_id")
#   end	
# end


