class Test < ActiveRecord::Base
	belongs_to :child
	#before_validation :set_bfeeding

#////////////////////////////////////////////////////////////////////////////////////////////
	as_enum :stools, [:three, :four, :five], map: :string, source: :stools
	as_enum :yes_appetite, [:very_good, :good, :poor, :very_poor], map: :string, source: :yes_appetite
	as_enum :referred_by, [:Own, :NRU, :otherOTP], :map => :string, source: :referred_by
	as_enum :complementery_food, [:Yes, :None], :map => :string, source: :complementery_food
	as_enum :breastfeeding, [:Yes, :No], :map => :string, source: :breastfeeding
	as_enum :vomiting, [:Yes, :No], :map => :string, source: :vomiting

#///////////////////////////////////////////////////////////////////////////////////////////
	scope :appetite_pass, lambda {where(:Appetite_test => true)}
	scope :appetite_fail, lambda {where(:Appetite_test => false)}

#//////////////////////////////////////////////////////////////////////////////////////////
	def set_breastfeeding(child)
		@age = child.age_in_months
		if @age.to_f > 24
			return self.breastfeeding = "Yes"
		else
			return self.breastfeeding = "No"
		end
	end

	def self.complementery_food
	end
end

#please do not un-comment the following code, it is for reference only

#====================================TEST MIGRATION FILE======================================
#/////////////////////////////////////////////////////////////////////////////////////////////

# class CreateTests < ActiveRecord::Migration
#   def change
#     create_table :tests do |t|
#     	t.references :child, :null => false
#     	t.string "referred_by", :limit => 10, null: false
#     	t.boolean "Appetite_test", :null => false
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


